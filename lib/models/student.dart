part of models;

class Student {
  String id;
  String firstName;
  String lastName;

  Student({this.id = '', this.firstName = '', this.lastName = ''});

  factory Student.fromDS(DataSnapshot data) {
    return Student(
        id: (data.key as String),
        firstName: (data.child('name').value as String),
        lastName: (data.child('lastName').value as String));
  }

  static Future<Iterable<Student>> allOnce() async {
    final event = await FirebaseDatabase.instance.ref('students').once();
    return event.snapshot.children.map((e) => Student.fromDS(e));
  }

  String name() => "$firstName  $lastName";
}
