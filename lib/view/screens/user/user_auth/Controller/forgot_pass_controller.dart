import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';

class ForgotPassController extends GetxController{
  


  // Future<void> sendEmailOTP(String email) async {
  //
  //     try {
  //       await FirebaseAuth.instance.c
  //       // Show a success message or navigate to a success screen.
  //     } catch (e) {
  //       // Handle any errors, e.g., if the password reset link has expired.
  //     }
  //   }



  Future<void> sendPasswordResetOTP(String email) async {
    final auth = FirebaseAuth.instance;
    // Generate a random OTP
    final otp = OTP.generateTOTPCodeString('YourSecretKey', DateTime.now().microsecond);

    try {
      final  resetLink = 'http://192.168.10.11:3000/resetPassword?email=$email&otp=$otp';
      await auth.sendPasswordResetEmail(
        email: email,
        // Use the OTP as the reset link or create a dynamic reset link.
        // For example: "${auth.currentUser?.email}/$otp"

      actionCodeSettings: ActionCodeSettings(url:resetLink,handleCodeInApp:true)
      );
      
      print("====> Send Otp");

      // // Show a success message or navigate to a success screen.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Password reset OTP sent. Check your inbox.'),
      //   ),
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OTPVerificationScreen(email: email, otp: otp),
      //   ),
      // );
    } catch (e) {
      // Handle any errors, e.g., if the email is not registered.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error: $e'),
      //   ),
      // );
    }
  }
  
  
  
}