import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SpSettingController extends GetxController{


/// <-------------------- Change Password ---------------->
  final currentPassCtrl= TextEditingController();
  final newPassCtrl= TextEditingController();
  final confirmPassCtrl= TextEditingController();
final FirebaseAuth _auth =FirebaseAuth.instance;
    var loading=false.obs;

  void changePassword(String currentPassword, String newPassword) async {

    try {
      loading(true);
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: currentPassword);
      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          confirmPassCtrl.clear();
          currentPassCtrl.clear();
          newPassCtrl.clear();
          Fluttertoast.showToast(msg:"Password updated successfully",toastLength: Toast.LENGTH_LONG);
          Get.back();
        }).catchError((error) {
          Fluttertoast.showToast(msg:"Error changing password");
          //Error, show something
        });
      }).catchError((err) {
        Fluttertoast.showToast(msg:"Current password incorrect");
      });
    } finally {
      loading(false);
    }


  }










}