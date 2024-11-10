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
    apiKey: 'AIzaSyBI4tDNAYI-69KjqEc6glxyEMja0-98gUE',
    appId: '1:759415617887:web:b6dfaa85899788d30ddeea',
    messagingSenderId: '759415617887',
    projectId: 'mobile-vault-5e4c8',
    authDomain: 'mobile-vault-5e4c8.firebaseapp.com',
    storageBucket: 'mobile-vault-5e4c8.appspot.com',
    measurementId: 'G-W87PTTGH3V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbEdJwmUIfaLLgcVouSekZURLT8ydZmVc',
    appId: '1:759415617887:android:a85a6bbe63b764a30ddeea',
    messagingSenderId: '759415617887',
    projectId: 'mobile-vault-5e4c8',
    storageBucket: 'mobile-vault-5e4c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBe7cAJb7xxzF6_ObM33N95wrYN4L1TISY',
    appId: '1:759415617887:ios:d59db8bc9fb8af170ddeea',
    messagingSenderId: '759415617887',
    projectId: 'mobile-vault-5e4c8',
    storageBucket: 'mobile-vault-5e4c8.appspot.com',
    iosBundleId: 'com.example.mobileVault',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBe7cAJb7xxzF6_ObM33N95wrYN4L1TISY',
    appId: '1:759415617887:ios:d59db8bc9fb8af170ddeea',
    messagingSenderId: '759415617887',
    projectId: 'mobile-vault-5e4c8',
    storageBucket: 'mobile-vault-5e4c8.appspot.com',
    iosBundleId: 'com.example.mobileVault',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBI4tDNAYI-69KjqEc6glxyEMja0-98gUE',
    appId: '1:759415617887:web:0dafcd2bdd0181930ddeea',
    messagingSenderId: '759415617887',
    projectId: 'mobile-vault-5e4c8',
    authDomain: 'mobile-vault-5e4c8.firebaseapp.com',
    storageBucket: 'mobile-vault-5e4c8.appspot.com',
    measurementId: 'G-037ZEX61CR',
  );
}
