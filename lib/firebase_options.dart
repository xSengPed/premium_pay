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
    apiKey: 'AIzaSyAZ4wT2Gd3m5bPAJCSlBW_lnjjZs37Phqc',
    appId: '1:699818837486:web:660ad3770cbed8b6463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    authDomain: 'ytp-paid-system.firebaseapp.com',
    storageBucket: 'ytp-paid-system.appspot.com',
    measurementId: 'G-289QJE4TK4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGeKewttfjlXBbpTuBX9zP8lXiBL3EFNw',
    appId: '1:699818837486:android:332cadadc8da1bad463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    storageBucket: 'ytp-paid-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD53Wc2g_3IeR7W9q-zniImIuNNm5HWprU',
    appId: '1:699818837486:ios:6f3638687e3bbb82463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    storageBucket: 'ytp-paid-system.appspot.com',
    iosClientId:
        '699818837486-od27m14inrsn84ra5rdu7poding79o1m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterYtApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD53Wc2g_3IeR7W9q-zniImIuNNm5HWprU',
    appId: '1:699818837486:ios:6f3638687e3bbb82463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    storageBucket: 'ytp-paid-system.appspot.com',
    iosClientId:
        '699818837486-od27m14inrsn84ra5rdu7poding79o1m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterYtApp',
  );
}
