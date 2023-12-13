

import 'package:wrcontacts/view/screens/user/user_auth/user_forget_password/forget_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController{
TextEditingController textEditingController=TextEditingController();
var loading=false.obs;
// Function to send password reset email
Future<void> resetPassword(String email,bool isInApp) async {
  try {
    loading(true);
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    textEditingController.clear();
      showDialog(
          context: Get.context!,
          barrierDismissible: true,
          builder: (BuildContext context){
            return  ForgetAlertDialog(inApp:isInApp,);
          }
      );
  } on FirebaseAuthException catch (e) {
  Fluttertoast.showToast(msg:"${e.message}");
   
    print('Error sending password reset email: ${e.code}');
  }finally{
    loading(false);
  }
}



}