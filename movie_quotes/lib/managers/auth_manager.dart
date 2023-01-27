import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager {
  User? _user;
  static final AuthManager instance = AuthManager._privateConstructor();

  StreamSubscription<User?>? _authListener;
  AuthManager._privateConstructor();

  final Map<UniqueKey, Function> _loginObservers = {};
  final Map<UniqueKey, Function> _logoutObservers = {};

  void startListening() {
    if (_authListener != null) {
      return;
    }
    _authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      bool isLoginEvent = user != null && _user == null;
      bool isLogoutEvent = user == null && _user != null;
      _user = user;

      if (isLoginEvent) {
        for (Function observer in _loginObservers.values) {
          observer();
        }
      }
      if (isLogoutEvent) {
        for (Function observer in _logoutObservers.values) {
          observer();
        }
      }

      // TODO: Delete this section once we know things work.
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!  Email: $email  Uid: $uid');
      }
    });
  }

  // Made for best practice, but never called in reality.
  void stopListening() {
    _authListener?.cancel();
    _authListener = null;
  }

  UniqueKey addLoginObserver(Function observer) {
    UniqueKey key = UniqueKey();
    _loginObservers[key] = observer;
    return key;
  }

  UniqueKey addLogoutObserver(Function observer) {
    UniqueKey key = UniqueKey();
    _logoutObservers[key] = observer;
    return key;
  }

  void removeObserver(UniqueKey key) {
    _loginObservers.remove(key);
    _logoutObservers.remove(key);
  }

  String get email => _user?.email ?? "";
  String get uid => _user?.uid ?? "";
  bool get isSignedIn => _user != null;

  // --- Specific auth methods...

  void createNewUserEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("AuthManager: Created a User ${credential.user?.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showAuthSnackbar(
            context: context,
            authErrorMessage: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        _showAuthSnackbar(
            context: context,
            authErrorMessage: "The account already exists for that email.");
      }
    } catch (e) {
      _showAuthSnackbar(context: context, authErrorMessage: e.toString());
    }
  }

  void _showAuthSnackbar({
    required BuildContext context,
    required String authErrorMessage,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(authErrorMessage),
      ),
    );
  }

  void logInExistingUserEmailPassword({
    required String email,
    required String password,
  }) {}
}
