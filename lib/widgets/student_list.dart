part of '../main.dart';

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
          return StyledCard(
              key: Key(student.id),
              child: ListTile(
                title: Text(student.name()),
                subtitle: Text("# ${index + 1}"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => AttendancePage(
                                student: student,
                              )));
                },
              ));
        });
  }
}
