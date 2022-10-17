import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MiastoError/list_of.dart';
import 'package:MiastoError/select_city.dart';
import 'package:MiastoError/start_screen.dart';
import 'package:provider/provider.dart';

import 'add_post.dart';
import 'firebase_options.dart';
import 'info_file.dart';
import 'map_screen.dart';
import 'settings.dart';
import 'login_screen.dart';
import 'presentation.dart';
import 'provider.dart';

const List<String> city = ["niepolomice"];
const List<String> typesOfPosts = [
  "wandalizm",
  "uszkodzenie mienia",
  "brak elementu",
  "usprawnienie działania",
  "własny tytuł"
];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  if (kDebugMode && !kProfileMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseFirestore.instance
          .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
      try {
        await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
      } catch (_) {}
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
      // ignore: avoid_print
      print(await FirebaseMessaging.instance.getToken());
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
      initialRoute: "/presentation",
      routes: {
        '/presentation': (context) => const Scaffold(body: Presentation()),
        '/register': (context) => const Scaffold(body: Start()),
        '/login': (context) => const Scaffold(body: Login()),
        '/home': (context) => const SafeArea(child: Scaffold(body: ListHome())),
        '/choose': (context) =>
            const SafeArea(child: Scaffold(body: SelectCity())),
        '/add': (context) => const SafeArea(child: Scaffold(body: AddPost())),
        '/settings': (context) => const Scaffold(body: SettingsScreen()),
        '/map': (context) => const Scaffold(body: MapScreen()),
        '/info': (context) => const Scaffold(body: InfoScreen()),
      },
    ),
  ));
}
