part of models;

class Homeroom {
  String id;
  String name;
  Iterable<String> studentIds;

  Homeroom({this.id = '', this.name = '', this.studentIds = const []});

  factory Homeroom.fromDS(DataSnapshot data) {
    final list = (data.child('students').value as List<Object?>);
    return Homeroom(
        id: (data.key as String),
        name: (data.child('name').value as String),
        studentIds: (list.map((e) => e as String)));
  }

  static Stream<Iterable<Homeroom>> all() {
    return FirebaseDatabase.instance.ref('homerooms').onValue.map(
        (event) => event.snapshot.children.map((ds) => Homeroom.fromDS(ds)));
  }

  static Stream<Homeroom> single(String id) {
    return FirebaseDatabase.instance
        .ref('homerooms/$id')
        .onValue
        .map((event) => Homeroom.fromDS(event.snapshot));
  }
}
