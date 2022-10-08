import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:miastoerror/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider with ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  String _email = "";
  String get email => _email;
  String _password = "";
  String get password => _password;
  String error = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _city = "";
  String get city => _city;
  List<DbPost> _posts = [];
  List<DbPost> get posts => _posts;

  // on create
  MyProvider() {
    print("provider created");
    if (FirebaseAuth.instance.currentUser != null) {
      _isSignedIn = true;
    } else {
      _isSignedIn = false;
    }
    () async {
      // final prefs = await SharedPreferences.getInstance();
      // _city = prefs.getString("city") ?? "";
      var data = await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      DbUser user = DbUser.fromFirestore(data.data()!);
      if (user.city != "") {
        _city = user.city;
        // gettings posts
        var data =
            await db.collection("posts").where("city", isEqualTo: _city).get();
        _posts = data.docs.map((e) => DbPost.fromFirestore(e.data())).toList();
        // addPost("test", "test2", "");
      }
    }();
    notifyListeners();
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
    // ignore: use_build_context_synchronously
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
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home');
  }

  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    _isSignedIn = false;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
    notifyListeners();
  }

  void setCity(String city) async {
    _city = city;
    DbUser user = DbUser(
      city: city,
    );
    db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toMap());
    notifyListeners();
  }

  void addPost(String title, String description, String image) async {
    DbPost post = DbPost(
      uidOfImage: image,
      city: _city,
      description: description,
      downvotes: [],
      upvotes: [],
      uidOfUser: FirebaseAuth.instance.currentUser!.uid,
    );
    db.collection("posts").add(post.toMap());
  }
}
