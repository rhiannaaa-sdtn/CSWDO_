import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html' as html;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isProcessing = false;

  // Function to send password reset email
  Future<void> _sendPasswordResetEmail() async {
    try {
      setState(() {
        _isProcessing = true;
      });
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      // Show confirmation message
      _showDialog("Password reset email sent. Please check your inbox.");
    } on FirebaseAuthException catch (e) {
      _showDialog("Error: ${e.message}");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  // Function to show a dialog
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
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
          color: Color.fromARGB(255, 3, 94, 168), // Main background color
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/SpcLogo.png", width: 100, height: 100, fit: BoxFit.cover),
              const SizedBox(height: 20),
              const Text(
                'City of San Pablo',
                style: TextStyle(
                  shadows: [
                    Shadow(offset: Offset(1, -.5), color: Colors.black),
                    Shadow(offset: Offset(1, .5), color: Colors.black),
                  ],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'City Social Welfare and Development Office',
                style: TextStyle(
                  shadows: [
                    Shadow(offset: Offset(1, -.5), color: Colors.black),
                    Shadow(offset: Offset(1, .5), color: Colors.black),
                  ],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Enter your email address to reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
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
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isProcessing ? null : _sendPasswordResetEmail,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(78, 115, 222, 1),
                          ),
                        ),
                        child: _isProcessing
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Send Reset Link',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/'),
                child: const Text(
                  'Back to Homepage',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
