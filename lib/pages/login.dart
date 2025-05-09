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
      backgroundColor: themeblue,

      body: Stack(
        children: [
          Container(
      decoration: BoxDecoration(
        color: themeblue, // existing background color
        image: DecorationImage(
          image: AssetImage("assets/images/undraw_medicine_hqqg.png"), // your image path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            themeblue.withOpacity(0.3), // blends with your theme color
            BlendMode.dstATop,
          ),
        ),
      ),
    ),
          Center(
            child: Container(
              width: 400, // fixed width
              height: 430, // fixed height
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 20,),
                  SizedBox(
                    // height: 60,
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back,",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Good to see you again!",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    // height: 60,
                    child: FormContainer(
                      prefixIcon: Icon(Icons.mail),
                      controller: _emailController,
                      hintText: 'Mail',
                      isPasswordField: false,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    // height: 60,
                    child: FormContainer(
                      prefixIcon: Icon(Icons.password),
                      controller: _passwordController,
                      hintText: 'Password',
                      isPasswordField: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                     onTap: () {
                _auth.logIn(
                  context: context,
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              },
                    child: Container(
                      width: 350,
                      height: 50,
                    
                      decoration: BoxDecoration(
                        color: themeblue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                          bottom: BorderSide(width: 2, color: themeblue),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
