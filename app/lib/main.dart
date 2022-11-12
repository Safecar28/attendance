import 'dart:async';
import 'dart:io';

import 'package:attendance/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:fl_chart/fl_chart.dart';
// The import below is required for the Firebase Authentication UI to work.
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as auth_ui;

import 'package:attendance/models/models.dart';

part 'screens/home_page.dart';
part 'screens/students_page.dart';
part 'screens/attendance_page.dart';
part 'screens/student_form.dart';
part 'screens/homeroom_form.dart';
part 'screens/reports_page.dart';
part 'screens/login.dart';

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
        // 'https://attendance-653e9-default-rtdb.asia-southeast1.firebasedatabase.app';
        'https://dev-cois-attendance-default-rtdb.asia-southeast1.firebasedatabase.app';
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

  // The root of the application.
  @override
  build(context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const Login(),
    );
  }
}
