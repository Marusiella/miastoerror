import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  String _email = "";
  String get email => _email;
  String _password = "";
  String get password => _password;
  String error = "";
  // on create
  MyProvider() {
    if (FirebaseAuth.instance.currentUser != null) {
      _isSignedIn = true;
    } else {
      _isSignedIn = false;
    }
  }
  void ifSignedIn(BuildContext context) {
    if (_isSignedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
    //  else {
    //   Navigator.pushReplacementNamed(context, '/login');
    // }
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        _isSignedIn = true;
      });
    } on FirebaseAuthException catch (e) {
      error = e.toString();
      notifyListeners();
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  void singUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        _isSignedIn = true;
      });
    } on FirebaseAuthException catch (e) {
      error = e.toString();
      notifyListeners();
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }
}
