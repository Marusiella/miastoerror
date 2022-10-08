import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miastoerror/start_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'provider.dart';

const List<String> city = ["niepolomice"];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProvider()),
    ],
    child: MaterialApp(
      initialRoute: "/login",
      routes: {
        '/register': (context) => const Scaffold(body: Start()),
        '/login': (context) => const Scaffold(body: Login()),
        '/home': (context) =>
            const SafeArea(top: false, child: Scaffold(body: Home())),
      },
    ),
  ));
}
