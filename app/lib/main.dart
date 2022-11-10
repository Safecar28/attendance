import 'dart:async';
import 'dart:io';

import 'package:attendance/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:attendance/models/models.dart';

part 'screens/home_page.dart';
part 'screens/students_page.dart';
part 'screens/attendance_page.dart';
part 'screens/student_form.dart';
part 'screens/homeroom_form.dart';

part 'widgets/homeroom_list.dart';
part 'widgets/student_list.dart';
part 'widgets/text_input.dart';
part 'widgets/current_date.dart';
part 'widgets/wait_err.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid && Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        name: 'Attendances', options: DefaultFirebaseOptions.currentPlatform);
    FirebaseDatabase.instance.databaseURL =
        'https://attendance-653e9-default-rtdb.asia-southeast1.firebasedatabase.app';
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
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
      home: const HomePage(title: 'Homerooms'),
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
