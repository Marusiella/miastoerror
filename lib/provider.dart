import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miastoerror/models.dart';

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
  double _latitude = 0;
  double get latitude => _latitude;
  double _longitude = 0;
  double get longitude => _longitude;
  bool isAdmin = false;
  bool get admin => isAdmin;
  Future<void> getPostNow() async {
    var data = await db
        .collection("posts")
        .where("city", isEqualTo: _city)
        .get(const GetOptions(source: Source.server));

    _posts =
        data.docs.map((e) => DbPost.fromFirestore(e.data(), e.id)).toList();

    notifyListeners();
  }

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

          isAdmin = user.isAdmin;
          await getPostNow();
          // gettings posts
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
    error = "";
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    error = "";
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
        _posts =
            data.docs.map((e) => DbPost.fromFirestore(e.data(), e.id)).toList();
        // addPost("test", "test2", "");
      }
    } catch (_) {}
    if (city == "") {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/choose');
    } else {
      Navigator.pop(context);
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
        _posts =
            data.docs.map((e) => DbPost.fromFirestore(e.data(), e.id)).toList();
        // addPost("test", "test2", "");
      }
    } catch (_) {}
    if (city == "") {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/choose');
    } else {
      Navigator.pop(context);
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
      isAdmin: false,
    );
    db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toMap());
    notifyListeners();
  }

  void addPost() async {
    var name = "images/${DateTime.now()}.jpg";
    var x = FirebaseStorage.instance.ref().child(name).putFile(File(this.url));
    var url = await (await x).ref.getDownloadURL();
    DbPost post = DbPost(
      id: "",
      title: title,
      uidOfImage: url,
      city: _city,
      description: description,
      downvotes: [],
      upvotes: [],
      uidOfUser: FirebaseAuth.instance.currentUser!.uid,
      latitude: latitude,
      longitude: longitude,
    );
    db.collection("posts").add(post.toMap());
    await getPostNow();
    notifyListeners();
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

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition();
    _latitude = position.latitude;
    _longitude = position.longitude;
    notifyListeners();
  }

  void deletePost(DbPost post, BuildContext context) {
    db.collection("posts").doc(post.id).delete();
    getPostNow();
    Navigator.of(context).pop();
  }
  // void addUpVote() async {
  //   var data = await db
  //       .collection("posts")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   DbUser user = DbUser.fromFirestore(data.data()!);
  //   if (user.city != "") {
  //     var
  //   }
  // }
}
