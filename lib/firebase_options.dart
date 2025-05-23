// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAPvQXnKTZmv6FDi2Ci9gKN6LyBcsChhDI',
    appId: '1:99260951523:web:0c60238283a1cd21444ed6',
    messagingSenderId: '99260951523',
    projectId: 'uaetask-b3731',
    authDomain: 'uaetask-b3731.firebaseapp.com',
    storageBucket: 'uaetask-b3731.appspot.com',
    measurementId: 'G-FE6P7VJXE5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpmAABRe4BLrKEqbBa9uM3KUGXc5tDujU',
    appId: '1:99260951523:android:9276cd043ecdb4ac444ed6',
    messagingSenderId: '99260951523',
    projectId: 'uaetask-b3731',
    storageBucket: 'uaetask-b3731.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnOWr7ZTSx63mu_Oc2P0hjfi2e95DYPtA',
    appId: '1:99260951523:ios:985e32320dfb020a444ed6',
    messagingSenderId: '99260951523',
    projectId: 'uaetask-b3731',
    storageBucket: 'uaetask-b3731.appspot.com',
    androidClientId: '99260951523-gn9bl3804u20r5m40nr73n1k3221q91i.apps.googleusercontent.com',
    iosClientId: '99260951523-rj5t0frkgcdjhr5kjmtfbq9oqe186j3e.apps.googleusercontent.com',
    iosBundleId: 'com.example.zartekMachine',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnOWr7ZTSx63mu_Oc2P0hjfi2e95DYPtA',
    appId: '1:99260951523:ios:985e32320dfb020a444ed6',
    messagingSenderId: '99260951523',
    projectId: 'uaetask-b3731',
    storageBucket: 'uaetask-b3731.appspot.com',
    androidClientId: '99260951523-gn9bl3804u20r5m40nr73n1k3221q91i.apps.googleusercontent.com',
    iosClientId: '99260951523-rj5t0frkgcdjhr5kjmtfbq9oqe186j3e.apps.googleusercontent.com',
    iosBundleId: 'com.example.zartekMachine',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAFglS6B-sheOC-zIHlnPvQCc3GV4ehSVg',
    appId: '1:99260951523:web:c5869a0b17357ff1444ed6',
    messagingSenderId: '99260951523',
    projectId: 'uaetask-b3731',
    authDomain: 'uaetask-b3731.firebaseapp.com',
    storageBucket: 'uaetask-b3731.appspot.com',
    measurementId: 'G-10RKYT7BJ6',
  );
}
