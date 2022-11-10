part of models;

class Homeroom {
  String name;
  Iterable<String> studentIds;

  Homeroom({this.name = '', this.studentIds = const []});

  factory Homeroom.fromDSS(DataSnapshot data) {
    final list = (data.child('students').value as List<Object?>);
    return Homeroom(
        name: (data.child('name').value as String),
        studentIds: (list.map((e) => e as String)));
  }
}
