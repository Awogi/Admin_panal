import 'package:admin_panal/pages/admin_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // admin credentials
  final String _email = "admin@gmail.com";
  final String _password = "password123";

  Future<User?> logIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    // Validate input fields
    if (email.isEmpty || password.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Missing Fields"),
          content: Text("Please fill all the fields"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return null;
    }

    // Check for hardcoded admin credentials
    if (email != _email || password != _password) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Access Denied"),
          content: Text("Unauthorized email. Only admin can access this panel."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return null;
    }

    try {
      // Show loading dialog
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => const Center(child: CircularProgressIndicator()),
      // );

      // Firebase sign-in
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;

      if (user != null) {
        // Save admin info in Firestore
        await _firestore.collection('admins').doc(user.uid).set({
          'email': email,
          'role': 'admin',
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Dismiss loading dialog
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }

        // Navigate to AdminPanel
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminPanel()),
          (route) => false,
        );
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Dismiss loading dialog if shown
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      // Prepare error message
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email.";
          break;
        case 'wrong-password':
          message = "Wrong password provided.";
          break;
        case 'too-many-requests':
          message = "Too many attempts. Try again later.";
          break;
        default:
          message = "Error: ${e.message}";
      }

      // Show error dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );

      return null;
    }
  }
}
