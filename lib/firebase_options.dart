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
    apiKey: 'AIzaSyBSXwT9h6xTUx44e10lSUT6v7pAxipYyZU',
    appId: '1:983289004509:web:6e1eb06b6e2a32c1413634',
    messagingSenderId: '983289004509',
    projectId: 'propertyapp-77dc8',
    authDomain: 'propertyapp-77dc8.firebaseapp.com',
    storageBucket: 'propertyapp-77dc8.appspot.com',
    measurementId: 'G-B4BZSHJ45W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjDf4q5Nf-ujJX2dd35_-LamrE5QVPiF0',
    appId: '1:983289004509:android:782e69949f2c5a30413634',
    messagingSenderId: '983289004509',
    projectId: 'propertyapp-77dc8',
    storageBucket: 'propertyapp-77dc8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVLR5zhi4kMi76Qo4y_bgc9VZm6tA1aLs',
    appId: '1:983289004509:ios:549d8263320ff4e6413634',
    messagingSenderId: '983289004509',
    projectId: 'propertyapp-77dc8',
    storageBucket: 'propertyapp-77dc8.appspot.com',
    iosClientId: '983289004509-oa4sgmq3mvvhg7h8ksqgs3gij5ohgo9g.apps.googleusercontent.com',
    iosBundleId: 'com.example.propertyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVLR5zhi4kMi76Qo4y_bgc9VZm6tA1aLs',
    appId: '1:983289004509:ios:becb114f6e1c366b413634',
    messagingSenderId: '983289004509',
    projectId: 'propertyapp-77dc8',
    storageBucket: 'propertyapp-77dc8.appspot.com',
    iosClientId: '983289004509-flklog45ppil01cuhg6570qlf7vr7i2h.apps.googleusercontent.com',
    iosBundleId: 'com.example.propertyApp.RunnerTests',
  );
}
