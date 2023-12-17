import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrcontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
   EmailVerificationScreen({super.key,required this.userType});
  String userType;

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _authController = Get.put(AuthenticationController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isEmailVerified = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _user?.reload();
    _sendEmailVerification();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      _checkEmailVerified();
    });
  }

  Future<void> _sendEmailVerification() async {
    await _user?.sendEmailVerification();
  }

  Future<void> _checkEmailVerified() async {
    await _user?.reload();
    setState(() {
      _isEmailVerified = _user?.emailVerified == true;
    });

    if (_isEmailVerified) {
      _timer.cancel(); // Stop the timer once email is verified
      _navigateToHomeScreen();
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
  }


  Future<void> _navigateToHomeScreen() async {
    await _authController.postDetailsToFireStore(widget.userType);
  }

  @override
  void dispose() {
    _signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: _buildVerificationStatus(),
      ),
    );
  }



  Widget _buildVerificationStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome, ${_user?.displayName ?? "Anonymous"}!',
          style: const TextStyle(fontSize: 18.0),
        ),
        const SizedBox(height: 20.0),
        Text(
          'Email: ${_user?.email}',
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 20.0),
        _isEmailVerified
            ? const Text(
          'Email Verified',
          style: TextStyle(fontSize: 18.0, color: Colors.green),
        )
            : ElevatedButton(
          onPressed: () {
            _sendEmailVerification();
          },
          child: const Text('Send Email Verification'),
        ),
      ],
    );
  }
}
