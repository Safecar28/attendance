part of models;

class Homeroom {
  String id;
  String name;
  Iterable<String> studentIds;

  Homeroom({this.id = '', this.name = '', this.studentIds = const []});

  factory Homeroom.fromDSS(DataSnapshot data) {
    final list = (data.child('students').value as List<Object?>);
    return Homeroom(
        id: (data.key as String),
        name: (data.child('name').value as String),
        studentIds: (list.map((e) => e as String)));
  }
}
