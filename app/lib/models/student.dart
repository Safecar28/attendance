part of models;

class Student {
  String id;
  String firstName;
  String lastName;

  Student({this.id = '', this.firstName = '', this.lastName = ''});

  factory Student.fromDS(
    DataSnapshot dbData,
  ) {
    return Student(
      id: (dbData.key as String),
      firstName: (dbData.child('firstName').value as String),
      lastName: (dbData.child('lastName').value as String),
    );
  }

  static Stream<Iterable<Student>> allOnce() {
    return FirebaseDatabase.instance
        .ref('students')
        .onValue
        .map((event) => event.snapshot.children.map((e) => Student.fromDS(e)));
  }

  static Future<void> upsertStudent(
      String? id, String firstName, String lastName, Homeroom homeroom) {
    final creating = id == null;
    id = id ?? studentID();

    // if creating add student to homeroom
    if (creating) {
      FirebaseDatabase.instance
          .ref('homerooms/${homeroom.id}/students')
          .push()
          .set(id);
    }

    return FirebaseDatabase.instance
        .ref('students/$id')
        .set({'id': id, 'firstName': firstName, 'lastName': lastName});
  }

  Future<void> removeFrom(Homeroom h) {
    final key = h.studentMap?.entries.firstWhere((e) => e.value == id).key;

    return FirebaseDatabase.instance
        .ref("homerooms/${h.id}/students/${key ?? '-'}")
        .remove();
  }

  String name() => '$firstName  $lastName';

  @override
  int get hashCode => Object.hash(id, id);

  @override
  bool operator ==(Object other) => other is Student && other.id == id;
}

String studentID() {
  return 'st-${customAlphabet(nanoIdChars, 7)}';
}

final studentsProvider = StreamProvider<Iterable<Student>>((ref) {
  return Student.allOnce();
});
