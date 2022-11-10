part of mainui;

class StudentPage extends StatefulWidget {
  const StudentPage({
    Key? key,
    required this.homeroomId,
    required this.allStudents,
  }) : super(key: key);

  final String homeroomId;
  final Iterable<Student> allStudents;

  @override
  createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Homeroom _homeroom = Homeroom();
  late StreamSubscription<DatabaseEvent> _homeroomSub;

  @override
  void initState() {
    super.initState();
    _homeroomSub = FirebaseDatabase.instance
        .ref('homerooms/${widget.homeroomId}')
        .onValue
        .listen((event) {
      setState(() {
        _homeroom = Homeroom.fromDSS(event.snapshot);
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    _homeroomSub.cancel();
  }

  @override
  build(BuildContext context) {
    var students = widget.allStudents
        .where((std) => _homeroom.studentIds.any((id) => id == std.id));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Take attendance'),
        ),
        body: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students.elementAt(index);
              return ListTile(
                title: Text(student.name()),
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
