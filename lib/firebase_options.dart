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
    apiKey: 'AIzaSyBiyl1FClwxNA-eUHdvITnN7L3KIXa4iug',
    appId: '1:10389515436:web:e668064efa2907f0740309',
    messagingSenderId: '10389515436',
    projectId: 'dexter-health',
    authDomain: 'dexter-health.firebaseapp.com',
    storageBucket: 'dexter-health.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOtxNayQL8pvwpSj1MF0kdOzX8EhCvVJs',
    appId: '1:10389515436:android:12a61cc5c0daef0a740309',
    messagingSenderId: '10389515436',
    projectId: 'dexter-health',
    storageBucket: 'dexter-health.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnmCEPymhBvJXCBm3Kgtg4ddymcvHGnRs',
    appId: '1:10389515436:ios:d4f08a98bc426db5740309',
    messagingSenderId: '10389515436',
    projectId: 'dexter-health',
    storageBucket: 'dexter-health.appspot.com',
    iosClientId:
        '10389515436-s1aqkaegecuj1pgaluhv0etpgjm36ckd.apps.googleusercontent.com',
    iosBundleId: 'com.example.dexterHealth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnmCEPymhBvJXCBm3Kgtg4ddymcvHGnRs',
    appId: '1:10389515436:ios:d4f08a98bc426db5740309',
    messagingSenderId: '10389515436',
    projectId: 'dexter-health',
    storageBucket: 'dexter-health.appspot.com',
    iosClientId:
        '10389515436-s1aqkaegecuj1pgaluhv0etpgjm36ckd.apps.googleusercontent.com',
    iosBundleId: 'com.example.dexterHealth',
  );
}
