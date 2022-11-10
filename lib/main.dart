import 'dart:async';

import 'package:attendance/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'models/models.dart';

part 'screens/home_page.dart';
part 'screens/students_page.dart';
part 'screens/attendance_page.dart';
part 'screens/student_form.dart';

part 'widgets/homeroom_list.dart';
part 'widgets/student_list.dart';
part 'widgets/wait_err.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(
    child: AttendanceApp(),
  ));
  // await debugDB();
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  build(context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(title: "Homerooms"),
    );
  }
}

Future<void> debugDB() async {
  // final dp1 = Homeroom.fromDS(
  //     await FirebaseDatabase.instance.ref('homerooms/dp1').get());

  // print("${dp1.name} has ${dp1.studentIds.length} students!");

  // final studentsRef = FirebaseDatabase.instance.ref('students');
  // final student =
  //     Student.fromDS(await studentsRef.child(dp1.studentIds.first).get());

  // print("${student.name()}!");
}
