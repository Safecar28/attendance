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

  static Future<void> upsertStudent(
      String? id, firstName, lastName, Homeroom homeroom) {
    final creating = id == null;
    id = id ?? studentID();

    // if creating add student to homeroom
    if (creating) {
      FirebaseDatabase.instance
          .ref("homerooms/${homeroom.id}/students")
          .set([...homeroom.studentIds, id]);
    }

    return FirebaseDatabase.instance
        .ref("students/$id")
        .set({'id': id, 'name': firstName, 'lastName': lastName});
  }

  String name() => "$firstName  $lastName";
}

String studentID() {
  return customAlphabet('1234567890-', 12);
}
