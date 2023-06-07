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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA1Gzf8V5M_tql0f-HTUSKi55DIv95gODA',
    appId: '1:802429472648:web:035a38e02c0d937a48b43d',
    messagingSenderId: '802429472648',
    projectId: 'discovery-26d4e',
    authDomain: 'discovery-26d4e.firebaseapp.com',
    storageBucket: 'discovery-26d4e.appspot.com',
    measurementId: 'G-BNLYZBSZNT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfpBPeG1A-ofQlEKA27LxzSfITBRRE0bk',
    appId: '1:802429472648:android:dfdc03c7ae20abe948b43d',
    messagingSenderId: '802429472648',
    projectId: 'discovery-26d4e',
    storageBucket: 'discovery-26d4e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4aO0M27kDVJFatkErYKYlA3IrVIhjYIc',
    appId: '1:802429472648:ios:69674c1bf5b1b52648b43d',
    messagingSenderId: '802429472648',
    projectId: 'discovery-26d4e',
    storageBucket: 'discovery-26d4e.appspot.com',
    iosClientId: '802429472648-i6e8167golcpa55mu81cqt5ltmsh7l1e.apps.googleusercontent.com',
    iosBundleId: 'com.Discovery.MET.discovery',
  );
}
