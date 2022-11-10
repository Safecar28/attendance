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

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder<Iterable<Homeroom>>(
            stream: _homerooms,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Wait();

              return HomeroomList(
                  homerooms: snapshot.data!, students: _students);
            }));
  }
}
