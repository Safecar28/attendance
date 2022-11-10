// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC21CnNWUO3ZECgP1b46TSm3iPDQkTvtEE',
    appId: '1:726228436483:android:4a40bfae5581bfc4837036',
    messagingSenderId: '726228436483',
    projectId: 'attendance-653e9',
    databaseURL:
        'https://attendance-653e9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'attendance-653e9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBX5HYQMnxgbiQQPfm_0ckJxRhupBzLQZA',
    appId: '1:726228436483:ios:0ff01c0a15c34940837036',
    messagingSenderId: '726228436483',
    projectId: 'attendance-653e9',
    databaseURL: 'http://localhost:9098/?ns=attendance-653e9',
    storageBucket: 'attendance-653e9.appspot.com',
    iosClientId:
        '726228436483-fcbujt4kj67t1dpdppfq0sc641nt6bh7.apps.googleusercontent.com',
    iosBundleId: 'com.example.attendance',
  );
}
