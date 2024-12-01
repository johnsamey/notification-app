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
    apiKey: 'AIzaSyCVP3VMdWGQ9Ajg-0K31LuUXIxs1rqZjdM',
    appId: '1:891587384934:web:4741e4a23bafc0ffe37fa7',
    messagingSenderId: '891587384934',
    projectId: 'cloud-task-1-7c777',
    authDomain: 'cloud-task-1-7c777.firebaseapp.com',
    storageBucket: 'cloud-task-1-7c777.firebasestorage.app',
    measurementId: 'G-XPZQBX97YY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtn6cdLIzvAseTAeAwXVVX5_I5JiKDbm4',
    appId: '1:891587384934:android:0ea8fb40e0b080f3e37fa7',
    messagingSenderId: '891587384934',
    projectId: 'cloud-task-1-7c777',
    storageBucket: 'cloud-task-1-7c777.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBN7mdSw1mIUJkU2NphhRUQJ7jT4oY_KCM',
    appId: '1:891587384934:ios:7d029daff2f2e178e37fa7',
    messagingSenderId: '891587384934',
    projectId: 'cloud-task-1-7c777',
    storageBucket: 'cloud-task-1-7c777.firebasestorage.app',
    iosBundleId: 'com.example.notificationApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBN7mdSw1mIUJkU2NphhRUQJ7jT4oY_KCM',
    appId: '1:891587384934:ios:7d029daff2f2e178e37fa7',
    messagingSenderId: '891587384934',
    projectId: 'cloud-task-1-7c777',
    storageBucket: 'cloud-task-1-7c777.firebasestorage.app',
    iosBundleId: 'com.example.notificationApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCVP3VMdWGQ9Ajg-0K31LuUXIxs1rqZjdM',
    appId: '1:891587384934:web:04b0b94ce203a98ce37fa7',
    messagingSenderId: '891587384934',
    projectId: 'cloud-task-1-7c777',
    authDomain: 'cloud-task-1-7c777.firebaseapp.com',
    storageBucket: 'cloud-task-1-7c777.firebasestorage.app',
    measurementId: 'G-N6DKYFM5KY',
  );
}
