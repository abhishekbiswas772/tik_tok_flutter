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
    apiKey: 'AIzaSyAtuBbb8yoBk04fSBTzSgAKGv7LxOROeFk',
    appId: '1:109767390024:web:f4da65ce4e576e4daa797d',
    messagingSenderId: '109767390024',
    projectId: 'tiktok-clone-6ceac',
    authDomain: 'tiktok-clone-6ceac.firebaseapp.com',
    storageBucket: 'tiktok-clone-6ceac.appspot.com',
    measurementId: 'G-NY1V9LCGKE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCUc-W3stxp3nEjVi9PwyUUA8MwohMn5Q',
    appId: '1:109767390024:android:39150309470a8edfaa797d',
    messagingSenderId: '109767390024',
    projectId: 'tiktok-clone-6ceac',
    storageBucket: 'tiktok-clone-6ceac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZO5RgJ7C-xmPZmj_ifdD-qawC46D2z_I',
    appId: '1:109767390024:ios:abbd1e9d9ca8b68eaa797d',
    messagingSenderId: '109767390024',
    projectId: 'tiktok-clone-6ceac',
    storageBucket: 'tiktok-clone-6ceac.appspot.com',
    iosBundleId: 'com.example.tiktokClone',
  );
}
