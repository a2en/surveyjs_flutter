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
    apiKey: 'AIzaSyAcOELhBQ89iuo0Vu4MXSizz3KMHxjOLwc',
    appId: '1:327988464537:web:884eac2058aa0a071ba108',
    messagingSenderId: '327988464537',
    projectId: 'surveyjs-28c33',
    authDomain: 'surveyjs-28c33.firebaseapp.com',
    storageBucket: 'surveyjs-28c33.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnHeSaB7sE0Ca0-2sQbxRoKxe-KWFSadM',
    appId: '1:327988464537:android:5b72f38c3cd00dfe1ba108',
    messagingSenderId: '327988464537',
    projectId: 'surveyjs-28c33',
    storageBucket: 'surveyjs-28c33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtm_nJ-GgyhysO1fT7cPqarQn_T317Jps',
    appId: '1:327988464537:ios:e51b7db1213de43a1ba108',
    messagingSenderId: '327988464537',
    projectId: 'surveyjs-28c33',
    storageBucket: 'surveyjs-28c33.appspot.com',
    iosClientId: '327988464537-7q3c25kt47mm8nb0tepj8471iipfli0j.apps.googleusercontent.com',
    iosBundleId: 'com.projile.surveyjs.surveyjsProjile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtm_nJ-GgyhysO1fT7cPqarQn_T317Jps',
    appId: '1:327988464537:ios:e51b7db1213de43a1ba108',
    messagingSenderId: '327988464537',
    projectId: 'surveyjs-28c33',
    storageBucket: 'surveyjs-28c33.appspot.com',
    iosClientId: '327988464537-7q3c25kt47mm8nb0tepj8471iipfli0j.apps.googleusercontent.com',
    iosBundleId: 'com.projile.surveyjs.surveyjsProjile',
  );
}
