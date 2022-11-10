part of mainui;

class StudentList extends StatelessWidget {
  const StudentList({
    Key? key,
    required this.students,
  }) : super(key: key);

  final Iterable<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students.elementAt(index);
          return ListTile(
            title: Text(student.name()),
          );
        });
  }
}
