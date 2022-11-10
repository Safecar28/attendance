part of mainui;

class StudentPage extends StatefulWidget {
  const StudentPage({
    Key? key,
    required this.homeroomId,
    required this.studentIds,
  }) : super(key: key);

  final String homeroomId;
  final Iterable<String> studentIds;

  @override
  createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  Iterable<Student> _allStudents = [];
  Iterable<Student> _students = [];
  final _db = FirebaseDatabase.instance.ref('students');

  @override
  void initState() {
    super.initState();
    final homeroom =
        FirebaseDatabase.instance.ref('homerooms/${widget.homeroomId}');
    _db.onValue.listen((event) {
      setState(() {
        _allStudents = event.snapshot.children.map((e) => Student.fromDSS(e));
      });
    });
    homeroom.onValue.listen((event) {
      setState(() {
        final h = Homeroom.fromDSS(event.snapshot);
        _students =
            _allStudents.where((std) => h.studentIds.any((id) => id == std.id));
      });
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Take attendance'),
        ),
        body: ListView.builder(
            itemCount: _students.length,
            itemBuilder: (context, index) {
              final student = _students.elementAt(index);
              return ListTile(
                title: Text(student.name()),
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
