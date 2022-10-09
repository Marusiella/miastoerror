import 'dart:io';

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
  String url = "";
  String get urlImage => url;
  String _description = "";
  String get description => _description;
  String _title = "";
  String get title => _title;

  // on create
  MyProvider() {
    print("provider created");
    if (FirebaseAuth.instance.currentUser != null) {
      _isSignedIn = true;
    } else {
      _isSignedIn = false;
    }
    () async {
      try {
        var data = await db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        DbUser user = DbUser.fromFirestore(data.data()!);
        if (user.city != "") {
          _city = user.city;
          notifyListeners();

          // gettings posts
          var data = await db
              .collection("posts")
              .where("city", isEqualTo: _city)
              .get();
          _posts =
              data.docs.map((e) => DbPost.fromFirestore(e.data())).toList();
          notifyListeners();
          // addPost("test", "test2", "");
        }
      } catch (_) {}
    }();
    notifyListeners();
  }
  void ifSignedIn(BuildContext context) async {
    if (_isSignedIn) {
      await Navigator.pushReplacementNamed(context, '/home');
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
          .signInWithEmailAndPassword(email: _email.trim(), password: _password)
          .then((value) {
        _isSignedIn = true;
      });
    } on FirebaseAuthException catch (e) {
      error = e.toString();
      notifyListeners();
      return;
    }
    try {
      var data = await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      DbUser user = DbUser.fromFirestore(data.data()!);
      if (user.city != "") {
        _city = user.city;
        notifyListeners();

        // gettings posts
        var data =
            await db.collection("posts").where("city", isEqualTo: _city).get();
        _posts = data.docs.map((e) => DbPost.fromFirestore(e.data())).toList();
        // addPost("test", "test2", "");
      }
    } catch (_) {}
    if (city == "") {
      Navigator.pushReplacementNamed(context, '/choose');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
    notifyListeners();
  }

  void singUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.trim(), password: _password)
          .then((value) {
        _isSignedIn = true;
      });
    } on FirebaseAuthException catch (e) {
      error = e.toString();
      notifyListeners();
      return;
    }
    try {
      var data = await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      DbUser user = DbUser.fromFirestore(data.data()!);
      if (user.city != "") {
        _city = user.city;
        notifyListeners();

        // gettings posts
        var data =
            await db.collection("posts").where("city", isEqualTo: _city).get();
        _posts = data.docs.map((e) => DbPost.fromFirestore(e.data())).toList();
        // addPost("test", "test2", "");
      }
    } catch (_) {}
    if (city == "") {
      Navigator.pushReplacementNamed(context, '/choose');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
    notifyListeners();
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

  void addPost() async {
    var name = "images/${DateTime.now()}.jpg";
    FirebaseStorage.instance.ref().child(name).putFile(File(url));
    DbPost post = DbPost(
      title: title,
      uidOfImage: name,
      city: _city,
      description: description,
      downvotes: [],
      upvotes: [],
      uidOfUser: FirebaseAuth.instance.currentUser!.uid,
    );
    db.collection("posts").add(post.toMap());
  }

  void addImage(String image) async {
    url = image;
    notifyListeners();
  }

  void setDescription(String description) async {
    _description = description;
    notifyListeners();
  }

  void setTitle(String title) async {
    _title = title;
    notifyListeners();
  }
}
