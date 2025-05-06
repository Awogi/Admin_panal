import 'package:admin_panal/pages/admin_panel.dart';
import 'package:admin_panal/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCbWy0dQhOZs9pZj-WUyjO9rNkjvgwX7f8",
        appId: "1:720700240813:web:1a871988350eb50bfae724",
        messagingSenderId: "720700240813",
        projectId: "quiz-app-5992c",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthWrapper());
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AdminPanel(); // User is logged in
        } else {
          return SignInPage(); // User is not logged in
        }
      },
    );
  }
}
