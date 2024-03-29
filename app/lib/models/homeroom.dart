part of models;

class Homeroom {
  String id;
  String name;
  Map<String, String>? studentMap;
  List<String> studentIds;
  StreamProviderRef<Homeroom>? ref;

  Homeroom(
      {this.id = '',
      this.name = '',
      this.studentIds = const [],
      this.studentMap});

  factory Homeroom.fromDS(DataSnapshot data) {
    final map = ((data.child('students').value ?? {}) as Map)
        .map((key, value) => MapEntry(key as String, value as String));

    final orderKeys = map.keys.toList()..sort();

    return Homeroom(
        id: (data.key as String),
        name: (data.child('name').value as String),
        studentMap: map,
        studentIds: orderKeys.map((e) => map[e] as String).toList());
  }

  factory Homeroom.fromDSRead(
      DataSnapshot data, StreamProviderRef<Homeroom> ref) {
    return Homeroom.fromDS(data)..ref = ref;
  }

  static Stream<Iterable<Homeroom>> all() {
    // using timestamp as key keep them sorted
    return FirebaseDatabase.instance
        .ref('homerooms')
        .orderByKey()
        .onValue
        .map((e) => e.snapshot.children.map((ds) => Homeroom.fromDS(ds)));
  }

  Future<Iterable<Student>> students() async {
    if (ref == null) return [];
    final students = await ref!.read(studentsProvider.future);
    return studentIds.map((id) => students.firstWhere((s) => s.id == id));
  }

  static Future<void> upsertHomeroom(String? id, String name) {
    id = id ?? homeroomID();
    return FirebaseDatabase.instance
        .ref('homerooms/$id')
        .update({'name': name});
  }
}

final homeroomProvider =
    StreamProvider.family<Homeroom, String>((homeroomRef, id) {
  return FirebaseDatabase.instance
      .ref('homerooms/$id')
      .onValue
      .map((event) => Homeroom.fromDSRead(event.snapshot, homeroomRef));
});

final homeroomsProvider =
    StreamProvider<Iterable<Homeroom>>((ref) => Homeroom.all());

///using timestamp to keep homerooms sorted
String homeroomID() =>
    'hr-${(DateTime.now().millisecondsSinceEpoch / 100).floor()}';
