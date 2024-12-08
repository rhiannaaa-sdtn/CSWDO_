import 'package:cwsdo/services/firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/admin/reliefRequest.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html; // Import dart:html for web storage
import 'dart:io'; // For platform-specific checks
import 'package:flutter/foundation.dart'; // For web-specific checks

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      final acc = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final user = _auth.currentUser;

      if (user != null) {
        // Retrieve user data (full name, office) from Firestore
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          // Assuming the Firestore document has 'fullName' and 'office' fields
          final fullName = userDoc['fullName'];
          final office = userDoc['office'];
            html.window.localStorage['fullName'] = fullName;
            html.window.localStorage['office'] = office;
          // Store these values in localStorage (for web)
          // if (kIsWeb) {
          //   // Use window.localStorage to store data for web platforms
          //   html.window.localStorage['fullName'] = fullName;
          //   html.window.localStorage['office'] = office;
          // } else {
          //   // For non-web platforms, use SharedPreferences
          //   SharedPreferences prefs = await SharedPreferences.getInstance();
          //   await prefs.setString('fullName', fullName);
          //   await prefs.setString('office', office);
          // }

          // Print to debug (optional)
          print('FullName: $fullName, Office: $office');

          // Navigate to the dashboard screen
          if(office == "CWSDO"){

          Navigator.pushNamed(context, '/dashboard');
          }else{

          Navigator.pushNamed(context, '/resident');
          }
        } else {
          _showErrorDialog('User data not found');
        }
      }
    } catch (e) {
      // Handle error
      _showErrorDialog('Login failed');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("images/bg1.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 3, 94, 168),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("images/SpcLogo.png",
                    width: 100, height: 100, fit: BoxFit.cover),
                const SizedBox(
                  width: 20,
                ),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  offset: Offset(1, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  offset: Offset(1, -.5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          'City of San Pablo'),
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  offset: Offset(1, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  offset: Offset(1, -.5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          'City Social Welfare and Development Office'),
                    ]),

                // Additional UI components here...
                const SizedBox(height: 10),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  offset: Offset(.2, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  offset: Offset(.2, -.5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          'Community Needs Assesment'),
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  offset: Offset(.2, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  offset: Offset(.2, -.5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                              Shadow(
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          'Management System (CNAMS)'),
                    ]),

                // Sign-in form
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Color.fromARGB(255, 183, 182, 182),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Text(
                          'Sign in to start Session',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromRGBO(78, 115, 222, 1))),
                          onPressed: _login,
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                            Expanded(
                                  flex: 5,
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () =>
                                        Navigator.pushNamed(context, '/'),
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15),
                                    ),
                                  ))),
                              Expanded(
                                  flex: 5,
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () =>
                                        Navigator.pushNamed(context, '/'),
                                    child: const Text(
                                      'Homepage',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15),
                                    ),
                                  ))),
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
