import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  // on create
  MyProvider() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      _isSignedIn = event != null;
      notifyListeners();
    });
  }
}
