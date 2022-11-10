part of '../main.dart';

class StudentList extends StatelessWidget {
  const StudentList({
    Key? key,
    required this.students,
    required this.homeroom,
    required this.add,
  }) : super(key: key);

  final Iterable<Student> students;
  final Homeroom homeroom;
  final void Function() add;

  addStudent(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => StudentForm(homeroom: homeroom)));
  }

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return EmptyListMessage(name: 'student', onPressed: add);
    }

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
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => StudentForm(
                                id: student.id,
                                firstName: student.firstName,
                                lastName: student.lastName,
                                homeroom: homeroom,
                              )));
                },
              ));
        });
  }
}

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("No ${name}s!"),
          ),
        ),
        Center(
          child: ElevatedButton(
              onPressed: onPressed, child: Text("Add your first $name")),
        )
      ],
    );
  }
}
