import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrcontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';

import '../../../../../utils/app_constents.dart';
import '../../../service_provider/Binding/provider_bottombar_binding.dart';
import '../../../service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import '../../Binding/user_bottom_binding.dart';
import '../../user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';

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
      await _user?.getIdToken(true);
      await FirebaseAuth.instance.currentUser!.reload();
       print("Email verified status: ${ FirebaseAuth.instance.currentUser!.emailVerified}");

      setState(() {
        _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified == true;
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

    } catch (e) {
      debugPrint("Error navigating to home screen: $e");
    }
  }

  @override
  void dispose() {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.email_outlined,size: 100,),
          const SizedBox(height: 20,),
          const Text("Verify your email address",
            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20.0),
          Text(
            "We have just send email verification link on your email. Please check email and click on that link to verify your email address.",
            style: TextStyle(fontSize: 16.0,color:Colors.grey.shade800),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
