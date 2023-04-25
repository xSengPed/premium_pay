import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static String apiKey = "";
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      apiKey = dotenv.env["API_KEY_WEB"] ?? "";
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        apiKey = dotenv.env["API_KEY_ANDROID"] ?? "";
        return android;
      case TargetPlatform.iOS:
        apiKey = dotenv.env["API_KEY_IOS"] ?? "";
        return ios;
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:699818837486:web:660ad3770cbed8b6463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    authDomain: 'ytp-paid-system.firebaseapp.com',
    storageBucket: 'ytp-paid-system.appspot.com',
    measurementId: 'G-289QJE4TK4',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:699818837486:android:332cadadc8da1bad463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    storageBucket: 'ytp-paid-system.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:699818837486:ios:6f3638687e3bbb82463aff',
    messagingSenderId: '699818837486',
    projectId: 'ytp-paid-system',
    storageBucket: 'ytp-paid-system.appspot.com',
    iosClientId:
        '699818837486-od27m14inrsn84ra5rdu7poding79o1m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterYtApp',
  );
}
