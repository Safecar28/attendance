part of '../main.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({
    Key? key,
    required this.homeroomId,
    required this.data,
  }) : super(key: key);

  final String homeroomId;
  final Iterable<Student> data;

  @override
  createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Stream<Homeroom> _homeroom;

  @override
  void initState() {
    super.initState();
    _homeroom = Homeroom.single(widget.homeroomId);
  }

  @override
  build(BuildContext context) {
    return StreamBuilder<Homeroom>(
        stream: _homeroom,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          var h = snapshot.data as Homeroom;
          var students = widget.data
              .where((std) => h.studentIds.any((id) => id == std.id));
          return Scaffold(
              appBar: AppBar(
                title: Text("${h.name} Students"),
              ),
              body: StudentList(students: students)
              // This trailing comma makes auto-formatting nicer for build methods.
              );
        });
  }
}
