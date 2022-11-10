part of mainui;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Iterable<Homeroom> _homerooms = [];
  late StreamSubscription<DatabaseEvent> _homeroomsSub;
  final _db = FirebaseDatabase.instance.ref('homerooms');

  @override
  void initState() {
    super.initState();
    _homeroomsSub = _db.onValue.listen((event) {
      setState(() {
        _homerooms = event.snapshot.children.map((e) => Homeroom.fromDSS(e));
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    _homeroomsSub.cancel();
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentPage(
                                homeroomId: homeroom.id,
                                studentIds: homeroom.studentIds,
                              )));
                },
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
