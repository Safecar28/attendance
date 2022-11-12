part of models;

final studentsProvider = StreamProvider<Iterable<Student>>((ref) {
  return Student.allOnce();
});

class Student {
  String id;
  String firstName;
  String lastName;
  Image? photo;

  Student({this.id = '', this.firstName = '', this.lastName = '', this.photo});

  factory Student.fromDS(
    DataSnapshot dbData,
    // [DataSnapshot? storageData,]
  ) {
    return Student(
      id: (dbData.key as String),
      firstName: (dbData.child('firstName').value as String),
      lastName: (dbData.child('lastName').value as String),
      // photo: storageData != null
      //     ? Image.memory(storageData.value as Uint8List)
      //     : Image.asset('images/placeholder.png'),
    );
  }

  static Stream<Iterable<Student>> allOnce() {
    // var dbStudentData =
    return FirebaseDatabase.instance
        .ref('students')
        .onValue
        .map((event) => event.snapshot.children.map((e) => Student.fromDS(e)));
    // var storageStudentData = FirebaseStorage.instance
    //     .ref('student_photos')
    //     .listAll()
    //     .asStream()
    //     .map((event) => event.items);
    // dbStudentData.map((students) {
    //   for (var student in students) {
    //     storageStudentData.map((event) {
    //       event.map((e) => student.photo = e.name.contains(student.id)
    //           ? Image.memory(e.getData() as Uint8List)
    //           : Image.asset('images/placeholder.png'));
    //     });
    //   }
    // });
    // return dbStudentData;
  }

  static Future<Image> photoFromId(String id) async {
    return Image.memory((await FirebaseStorage.instance
        .ref('student_photos')
        .child(id)
        .getData())!);
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
