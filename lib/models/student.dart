part of models;

class Student {
  String firstName;
  String lastName;
  Student({this.firstName = '', this.lastName = ''});

  factory Student.fromDSS(DataSnapshot data) {
    return Student(
        firstName: (data.child('name').value as String),
        lastName: (data.child('lastName').value as String));
  }

  static Iterable<Student> fromDBRef(DatabaseReference ref) {
    return const [];
  }

  String name() => "$firstName  $lastName";
}
