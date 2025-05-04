import 'package:admin_panal/firebase_services/authentication.dart';
import 'package:admin_panal/firebase_services/form_container.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widget/constant_color.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthenticationService _auth = AuthenticationService();
  CollectionReference collRef = FirebaseFirestore.instance.collection('admin');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    collRef.add({'name': _emailController.text});

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      //  SingleChildScrollView(
      //   child:
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.01,
              left:
                  0, // Added left positioning to ensure the container is full width
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: themeblue,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(30),
                    left: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left:
                  0, // Added left positioning to ensure the container is full width
              right: 0,
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.13,
                  fontFamily: "Ubuntu",
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left:
                  kIsWeb
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1,
              right:
                  kIsWeb
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                // width:
                //     kIsWeb
                //         ? MediaQuery.of(context).size.width * 0.7
                //         : MediaQuery.of(context).size.width * 0.8,
                height:
                    kIsWeb
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.width * 0.18,
                child: FormContainer(
                  prefixIcon: Icon(Icons.mail),
                  controller: _emailController,
                  hintText: 'Mail',
                  isPasswordField: false,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.55,
              left:
                  kIsWeb
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1,
              right:
                  kIsWeb
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                // width:
                //     kIsWeb
                //         ? MediaQuery.of(context).size.width * 0.7
                //         : MediaQuery.of(context).size.width * 0.8,
                height:
                    kIsWeb
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.width * 0.18,
                child: FormContainer(
                  prefixIcon: Icon(Icons.password),
                  controller: _passwordController,
                  hintText: 'password',
                  isPasswordField: true,
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.68,
              left:
                  kIsWeb
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1,
              right:
                  kIsWeb
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1,
              child: GestureDetector(
                onTap: () {
                  _auth.logIn(
                    context: context,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                child: Container(
                  // width:
                  //     kIsWeb
                  //         ? MediaQuery.of(context).size.width * 0.6
                  //         : MediaQuery.of(context).size.width * 0.5,
                  height:
                      kIsWeb
                          ? MediaQuery.of(context).size.height * 0.07
                          : MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeblue,
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontFamily: "Ubuntu",
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
