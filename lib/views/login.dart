import 'package:cwsdo/services/firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/admin/reliefRequest.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'home_screen.dart'; // Create a home screen after login

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  // final CheckAuth checkAuth = CheckAuth();

  void _login() async {
    try {
      final acc = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final user = _auth.currentUser;

      Navigator.pushNamed(context, '/dashboard');

      // print(user);
      // Navigate to home screen after successful login
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //       builder: (context) => const Sidebar(
      //             content: Reliefrequest(),
      //           )),
      // );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
        // SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // _auth.currentUser

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          // color: Colors.blue,
          image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0x9C2196F3),
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
                                  // bottomLeft
                                  offset: Offset(1, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1, -.5),
                                  color: Colors.black),
                              Shadow(
                                  // topRight
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                              Shadow(
                                  // topLeft
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'City of San Pablo'),
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(1, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1, -.5),
                                  color: Colors.black),
                              Shadow(
                                  // topRight
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                              Shadow(
                                  // topLeft
                                  offset: Offset(1, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'City Social Welfare andd Development Office'),
                    ]),
                const SizedBox(height: 30),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(.2, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(.2, -.5),
                                  color: Colors.black),
                              Shadow(
                                  // topRight
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                              Shadow(
                                  // topLeft
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'Community Needs Assesment'),
                      Text(
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(.2, -.5),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(.2, -.5),
                                  color: Colors.black),
                              Shadow(
                                  // topRight
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                              Shadow(
                                  // topLeft
                                  offset: Offset(.2, .5),
                                  color: Colors.black),
                            ],
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'Management System (CNAMS)'),
                    ]),
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Color.fromARGB(255, 183, 182, 182),
                        Color.fromARGB(255, 255, 255, 255),
                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
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
                              shape:
                                  WidgetStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              backgroundColor: const WidgetStatePropertyAll(
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
                              const Expanded(
                                  flex: 5, child: Center(child: Text(''))),
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
                                  )))
                            ])
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

          // Container(
          //     height: MediaQuery.of(context).size.height * .9,
          //     width: double.maxFinite,
          //     decoration: const BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage("images/bg1.png"),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     child: const Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           CustomWidg(txt: 'Community Needs Assesment', fsize: 80),
          //           CustomWidg(txt: 'Management System', fsize: 80),
          //           SizedBox(height: 20),
          //           CustomWidg(txt: 'City of San Pablo', fsize: 30),
          //           CustomWidg(
          //               txt: 'City Social Welfare and Development Office',
          //               fsize: 30),
          //         ])),