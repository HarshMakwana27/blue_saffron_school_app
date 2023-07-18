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
    apiKey: 'AIzaSyC4qjyTiBNdN_tmYVmLZ5rBJqKRAqnrD7s',
    appId: '1:7135927870:android:a13e56da1cd7f0552d7b6f',
    messagingSenderId: '7135927870',
    projectId: 'bluesaffron-d1ba1',
    databaseURL: 'https://bluesaffron-d1ba1-default-rtdb.firebaseio.com',
    storageBucket: 'bluesaffron-d1ba1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVp_hehU6tV82auSCKqBPusWlDH1_Jg4k',
    appId: '1:7135927870:ios:ba24e7dbe0051e162d7b6f',
    messagingSenderId: '7135927870',
    projectId: 'bluesaffron-d1ba1',
    databaseURL: 'https://bluesaffron-d1ba1-default-rtdb.firebaseio.com',
    storageBucket: 'bluesaffron-d1ba1.appspot.com',
    iosClientId: '7135927870-d11bddjcar3gsstf0r6humfs8avtq4c1.apps.googleusercontent.com',
    iosBundleId: 'com.example.school',
  );
}
