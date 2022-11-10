import 'package:attendance/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AttendanceApp());
  // await debugDB();
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'COIS Attendance',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(title: 'Homerooms'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Iterable<Homeroom> _homerooms = [];
  final _db = FirebaseDatabase.instance.ref('homerooms');

  @override
  void initState() {
    super.initState();
    _db.onValue.listen((event) {
      setState(() {
        _homerooms = event.snapshot.children.map((e) => Homeroom.fromDSS(e));
      });
    });
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
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Future<void> debugDB() async {
  final dp1 = Homeroom.fromDSS(
      await FirebaseDatabase.instance.ref('homerooms/dp1').get());

  print("${dp1.name} has ${dp1.studentIds.length} students!");

  final studentsRef = FirebaseDatabase.instance.ref('students');
  final student =
      Student.fromDSS(await studentsRef.child(dp1.studentIds.first).get());

  print("${student.name()}!");
}
