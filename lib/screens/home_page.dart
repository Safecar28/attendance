part of '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homerooms = Homeroom.all();
  final Future<Iterable<Student>> _students = Student.allOnce();
  static const wait = Center(child: CircularProgressIndicator());

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<Iterable<Student>>(
            future: _students,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return wait;

              var students = snapshot.data!;
              return StreamBuilder<Iterable<Homeroom>>(
                  stream: _homerooms,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return wait;

                    final data = snapshot.data!;
                    return HomeroomList(homerooms: data, students: students);
                  });
            }));
  }
}
