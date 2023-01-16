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
    apiKey: 'AIzaSyCMiYW9GyvLeekKTBh4EHjayO6qGVeZqC0',
    appId: '1:38445886992:web:fb6c570d39d1efb2612495',
    messagingSenderId: '38445886992',
    projectId: 'yiny1-movie-quotes',
    authDomain: 'yiny1-movie-quotes.firebaseapp.com',
    storageBucket: 'yiny1-movie-quotes.appspot.com',
    measurementId: 'G-62PFSVHXVE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaFvtjCgYZQ6RRFQ62yr7PAhLQ_fxtJoA',
    appId: '1:38445886992:android:0366a2e1053a5a69612495',
    messagingSenderId: '38445886992',
    projectId: 'yiny1-movie-quotes',
    storageBucket: 'yiny1-movie-quotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-G16QnsxZ9vukSxLdHFnWB9gv5HNOU_M',
    appId: '1:38445886992:ios:3c7973f3435e9baa612495',
    messagingSenderId: '38445886992',
    projectId: 'yiny1-movie-quotes',
    storageBucket: 'yiny1-movie-quotes.appspot.com',
    iosClientId: '38445886992-8pbmdt7rp18sdov2hii0uf58p9g074fh.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieQuotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-G16QnsxZ9vukSxLdHFnWB9gv5HNOU_M',
    appId: '1:38445886992:ios:3c7973f3435e9baa612495',
    messagingSenderId: '38445886992',
    projectId: 'yiny1-movie-quotes',
    storageBucket: 'yiny1-movie-quotes.appspot.com',
    iosClientId: '38445886992-8pbmdt7rp18sdov2hii0uf58p9g074fh.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieQuotes',
  );
}
