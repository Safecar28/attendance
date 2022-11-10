part of mainui;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Iterable<Homeroom> _homerooms = [];
  Iterable<Student> _students = [];
  late StreamSubscription<DatabaseEvent> _homeroomsSub;
  late StreamSubscription<DatabaseEvent> _studentsSub;

  @override
  void initState() {
    super.initState();
    _homeroomsSub =
        FirebaseDatabase.instance.ref('homerooms').onValue.listen((event) {
      setState(() {
        _homerooms = event.snapshot.children.map((e) => Homeroom.fromDSS(e));
      });
    });
    _studentsSub =
        FirebaseDatabase.instance.ref('students').onValue.listen((event) {
      setState(() {
        _students = event.snapshot.children.map((e) => Student.fromDSS(e));
      });
    });
  }

  void _handleTap(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentPage(
                  homeroomId: id,
                  allStudents: _students,
                )));
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: _homerooms.length,
            itemBuilder: (context, index) {
              final homeroom = _homerooms.elementAt(index);
              return ListTile(
                title: Text(homeroom.name),
                subtitle: Text("${homeroom.studentIds.length} students"),
                onTap: () => _handleTap(homeroom.id),
              );
            }));
  }

  @override
  void deactivate() {
    super.deactivate();
    _homeroomsSub.cancel();
    _studentsSub.cancel();
  }
}
