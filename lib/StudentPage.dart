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
  late Homeroom _homeroom;
  late StreamSubscription<DatabaseEvent> _studentsSub;
  late StreamSubscription<DatabaseEvent> _studentChangeSub;
  late StreamSubscription<DatabaseEvent> _homeroomSub;
  final _db = FirebaseDatabase.instance.ref('students');

  @override
  void initState() {
    super.initState();
    _studentsSub = _db.onValue.listen((event) {
      setState(() {
        _allStudents = event.snapshot.children.map((e) => Student.fromDSS(e));
      });
    });
    _studentChangeSub = _db.onChildChanged.listen((event) {
      _allStudents = _allStudents.map((e) {
        if (event.snapshot.key != e.id) return e;
        return Student.fromDSS(event.snapshot);
      });
    });
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
    _studentsSub.cancel();
    _studentChangeSub.cancel();
    _homeroomSub.cancel();
  }

  @override
  build(BuildContext context) {
    var students = _allStudents
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
