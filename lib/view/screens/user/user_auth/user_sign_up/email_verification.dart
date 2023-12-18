import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrcontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
  EmailVerificationScreen({Key? key, required this.userType}) : super(key: key);

  final String userType;

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _authController = Get.put(AuthenticationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  bool _isEmailVerified = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;

    if (_user != null) {
      _sendEmailVerification();
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        debugPrint("Check email verification");
        _checkEmailVerified();
      });
    } else {
      debugPrint("User is null");
    }
  }

  Future<void> _sendEmailVerification() async {
    try {
      await _user?.sendEmailVerification();
    } catch (e) {
      print("Error sending email verification: $e");
    }
  }

  Future<void> _checkEmailVerified() async {
    try {
      await _user!.reload();
      print("Email verified status: ${_user?.emailVerified}");

      setState(() {
        _isEmailVerified = _user?.emailVerified == true;
      });

      if (_isEmailVerified) {
        print("Checking email verification: Verified");
        _timer.cancel(); // Stop the timer once email is verified
        _navigateToHomeScreen();
      } else {
        print("Checking email verification: Not verified");
      }
    } catch (e) {
      print("Error checking email verification: $e");
    }
  }


  Future<void> _accountDelete() async {
    try {
      await _auth.currentUser?.delete();
      debugPrint("Account Delete");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> _navigateToHomeScreen() async {
    try {
      debugPrint("Account Create and verification completed");
      await _authController.postDetailsToFireStore(widget.userType);
    } catch (e) {
      print("Error navigating to home screen: $e");
    }
  }

  @override
  void dispose() {
    _accountDelete();
    _timer.cancel();
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
