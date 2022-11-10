part of models;

class Homeroom {
  String id;
  String name;
  Map<String, String>? studentMap;
  List<String> studentIds;
  Reader? read;

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

  factory Homeroom.fromDSRead(DataSnapshot data, Reader read) {
    final h = Homeroom.fromDS(data);
    h.read = read;
    return h;
  }

  static Stream<Iterable<Homeroom>> all() {
    return FirebaseDatabase.instance.ref('homerooms').orderByKey().onValue.map(
        (event) => event.snapshot.children.map((ds) => Homeroom.fromDS(ds)));
  }

  Future<Iterable<Student>> students() async {
    if (read == null) return [];
    final students = await read!(studentsProvider.future);
    return studentIds.map((id) => students.firstWhere((s) => s.id == id));
  }

  static Future<void> upsertHomeroom(String? id, String name) {
    id = id ?? homeroomID();
    return FirebaseDatabase.instance
        .ref('homerooms/$id')
        .update({'name': name});
  }
}

final homeroomProvider = StreamProvider.family<Homeroom, String>((ref, id) {
  return FirebaseDatabase.instance
      .ref('homerooms/$id')
      .onValue
      .map((event) => Homeroom.fromDSRead(event.snapshot, ref.read));
});

final homeroomsProvider =
    StreamProvider<Iterable<Homeroom>>((ref) => Homeroom.all());

String homeroomID() {
  return 'hr-${DateTime.now().millisecondsSinceEpoch}';
}
