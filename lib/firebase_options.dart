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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDh_qty0EN2NO6h12mxONIOlD93YaLzWmw',
    appId: '1:955902871586:web:485f6df544f04e21b1227b',
    messagingSenderId: '955902871586',
    projectId: 'medlife-da560',
    authDomain: 'medlife-da560.firebaseapp.com',
    storageBucket: 'medlife-da560.appspot.com',
    measurementId: 'G-Q3DGPC0NDK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDj3ofGrYa_lofKBTyMcgpsrrWCuHEDM0Y',
    appId: '1:955902871586:android:17c8a679fda69d3bb1227b',
    messagingSenderId: '955902871586',
    projectId: 'medlife-da560',
    storageBucket: 'medlife-da560.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBYaQQ5lrnzJgPK6G0XI0L8_q7W9_g1TIs',
    appId: '1:955902871586:ios:e197ff16051d7167b1227b',
    messagingSenderId: '955902871586',
    projectId: 'medlife-da560',
    storageBucket: 'medlife-da560.appspot.com',
    iosClientId:
        '955902871586-uihns86s461k4skcpaikj6j0b8rkqjs4.apps.googleusercontent.com',
    iosBundleId: 'com.example.medlifeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBYaQQ5lrnzJgPK6G0XI0L8_q7W9_g1TIs',
    appId: '1:955902871586:ios:e197ff16051d7167b1227b',
    messagingSenderId: '955902871586',
    projectId: 'medlife-da560',
    storageBucket: 'medlife-da560.appspot.com',
    iosClientId:
        '955902871586-uihns86s461k4skcpaikj6j0b8rkqjs4.apps.googleusercontent.com',
    iosBundleId: 'com.example.medlifeApp',
  );
}
