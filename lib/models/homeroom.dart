part of models;

final homeroomProvider = StreamProvider.family<Homeroom, String>((ref, id) {
  return FirebaseDatabase.instance
      .ref('homerooms/$id')
      .onValue
      .map((event) => Homeroom.fromDSRead(event.snapshot, ref.read));
});

final homeroomsProvider =
    StreamProvider<Iterable<Homeroom>>((ref) => Homeroom.all());

class Homeroom {
  String id;
  String name;
  Iterable<String> studentIds;
  Reader? read;

  Homeroom({this.id = '', this.name = '', this.studentIds = const []});

  factory Homeroom.fromDS(DataSnapshot data) {
    final list = (data.child('students').value as List<Object?>);
    return Homeroom(
        id: (data.key as String),
        name: (data.child('name').value as String),
        studentIds: (list.map((e) => e as String)));
  }

  factory Homeroom.fromDSRead(DataSnapshot data, Reader read) {
    final h = Homeroom.fromDS(data);
    h.read = read;
    return h;
  }

  static Stream<Iterable<Homeroom>> all() {
    return FirebaseDatabase.instance.ref('homerooms').onValue.map(
        (event) => event.snapshot.children.map((ds) => Homeroom.fromDS(ds)));
  }

  Future<Iterable<Student>> students() async {
    if (read == null) return [];
    final students = await read!(studentsProvider.future);
    return students.where((std) => studentIds.any((id) => id == std.id));
  }
}
