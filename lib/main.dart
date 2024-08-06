import 'dart:io';
import 'package:bms_tracker/Components/LocalNotification.dart';
import 'package:bms_tracker/login.dart';
import 'package:bms_tracker/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyCJyo52w4ldUx6CCb7TIsiT8zrsSItEWpI",
            appId: "1:880670370362:android:022485b144a001ecfb6303",
            messagingSenderId: "880670370362",
            projectId: "bmsproject-25fc0",
          ),
        )
      : await Firebase.initializeApp();
  await LocalNotifications.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _StateMyApp();
}

class _StateMyApp extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(fontFamily: "calibri"),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : HomePage(),
      routes: {
        "Login": (context) => const Login(),
        "HomePage": (context) => HomePage(),
      },
    );
  }
}
