part of models;

final studentsProvider = StreamProvider<Iterable<Student>>((ref) {
  return Student.allOnce();
});

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

  static Stream<Iterable<Student>> allOnce() {
    return FirebaseDatabase.instance
        .ref('students')
        .onValue
        .map((event) => event.snapshot.children.map((e) => Student.fromDS(e)));
  }

  String name() => "$firstName  $lastName";
}
