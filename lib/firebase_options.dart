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
    apiKey: 'AIzaSyBAEearXiaoAI5n5NYBcHSZgPrgjRdicOc',
    appId: '1:58059103944:web:ce11e00b123b86d0958ffd',
    messagingSenderId: '58059103944',
    projectId: 'tempo-property-app',
    authDomain: 'tempo-property-app.firebaseapp.com',
    storageBucket: 'tempo-property-app.appspot.com',
    measurementId: 'G-E29DTR865C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXrSlP2B5VAKt4lKwi7t-GyBJkehkybVQ',
    appId: '1:58059103944:android:a29ef86de1fba73f958ffd',
    messagingSenderId: '58059103944',
    projectId: 'tempo-property-app',
    storageBucket: 'tempo-property-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjye_TWEkgOc-_jdNy4_Ch8DL1J_7V8qo',
    appId: '1:58059103944:ios:5d547cb6687be873958ffd',
    messagingSenderId: '58059103944',
    projectId: 'tempo-property-app',
    storageBucket: 'tempo-property-app.appspot.com',
    iosClientId: '58059103944-2in79m8av1q4ccr4qdqdk2svsgtrjo61.apps.googleusercontent.com',
    iosBundleId: 'com.example.propertyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjye_TWEkgOc-_jdNy4_Ch8DL1J_7V8qo',
    appId: '1:58059103944:ios:7974012fa4a25aef958ffd',
    messagingSenderId: '58059103944',
    projectId: 'tempo-property-app',
    storageBucket: 'tempo-property-app.appspot.com',
    iosClientId: '58059103944-cd7clkikqluqov0na3lam18trj8lb32q.apps.googleusercontent.com',
    iosBundleId: 'com.example.propertyApp.RunnerTests',
  );
}
