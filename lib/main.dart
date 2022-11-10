library mainui;

import 'dart:async';

import 'package:attendance/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'models/models.dart';

part 'HomePage.dart';
part 'StudentPage.dart';

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

Future<void> debugDB() async {
  final dp1 = Homeroom.fromDSS(
      await FirebaseDatabase.instance.ref('homerooms/dp1').get());

  print("${dp1.name} has ${dp1.studentIds.length} students!");

  final studentsRef = FirebaseDatabase.instance.ref('students');
  final student =
      Student.fromDSS(await studentsRef.child(dp1.studentIds.first).get());

  print("${student.name()}!");
}
