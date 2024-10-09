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
    apiKey: 'AIzaSyCARDgNs6SBdNnFihvRjeK76Tubl8IXVMM',
    appId: '1:125404204074:web:70e13f1422f0a12216c753',
    messagingSenderId: '125404204074',
    projectId: 'insta-project-4ecd9',
    authDomain: 'insta-project-4ecd9.firebaseapp.com',
    storageBucket: 'insta-project-4ecd9.appspot.com',
    measurementId: 'G-VKEP4RKET9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWEig62qRxHExH04shux-pUV0Z2Ahs8-w',
    appId: '1:125404204074:android:e809ebc1a584853b16c753',
    messagingSenderId: '125404204074',
    projectId: 'insta-project-4ecd9',
    storageBucket: 'insta-project-4ecd9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0BSvPjUB_boaSm8VJWzQDof3oFDJj09U',
    appId: '1:125404204074:ios:15c5e37aa90f502816c753',
    messagingSenderId: '125404204074',
    projectId: 'insta-project-4ecd9',
    storageBucket: 'insta-project-4ecd9.appspot.com',
    iosBundleId: 'com.example.instagramProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0BSvPjUB_boaSm8VJWzQDof3oFDJj09U',
    appId: '1:125404204074:ios:15c5e37aa90f502816c753',
    messagingSenderId: '125404204074',
    projectId: 'insta-project-4ecd9',
    storageBucket: 'insta-project-4ecd9.appspot.com',
    iosBundleId: 'com.example.instagramProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCARDgNs6SBdNnFihvRjeK76Tubl8IXVMM',
    appId: '1:125404204074:web:b1bdd5f6192feda816c753',
    messagingSenderId: '125404204074',
    projectId: 'insta-project-4ecd9',
    authDomain: 'insta-project-4ecd9.firebaseapp.com',
    storageBucket: 'insta-project-4ecd9.appspot.com',
    measurementId: 'G-TPC68W27C4',
  );
}