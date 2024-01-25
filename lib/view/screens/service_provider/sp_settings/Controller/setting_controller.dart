import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_constents.dart';

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
          Fluttertoast.showToast(msg:"Password updated successfully".tr,toastLength: Toast.LENGTH_LONG);
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




  FirebaseFirestore  _firebaseFirestore =FirebaseFirestore.instance;



  RxString termsOfCondition="".obs;
  RxString privacyPolicy="".obs;
  RxString aboutUs="".obs;
  RxString support="".obs;

  var otherLoading=false.obs;


  getTermsOfCondition()async{
    try {
      otherLoading(true);
      final result=  await _firebaseFirestore.collection(AppConstants.termsConditions).doc("provider_terms_and_condition").get();
      print("=========> ${result.data()}");

      Map<String,dynamic>? data=result.data();
      termsOfCondition.value=data!['body'];
      print("=========> ${termsOfCondition.value}");
      otherLoading(false);
    } catch (e) {
      debugPrint("Terms and Condition");
    }
  }

  getAboutUs()async{
    try {
      otherLoading(true);
      final result=  await _firebaseFirestore.collection(AppConstants.aboutUs).doc("provider_about_us").get();
      Map<String,dynamic>? data=result.data();
      aboutUs.value=data!['body'];
      print("=========> ${aboutUs.value}");
      otherLoading(false);
    } catch (e) {
      debugPrint("Error About us");
    }
  }

  getPrivacyPolicy()async{
    try {
      otherLoading(true);
      final result=  await _firebaseFirestore.collection(AppConstants.privacyPolicy).doc("provider_privacy_policy").get();
      print("=========> ${result.data()}");

      Map<String,dynamic>? data=result.data();
      privacyPolicy.value=data!['body'];
      print("=========> ${privacyPolicy.value}");
      otherLoading(false);
    } catch (e) {
      debugPrint("Error Privacy Policy");
    }
  }

  getSupport()async{
    try {
      otherLoading(true);
      final result=  await _firebaseFirestore.collection(AppConstants.support).doc("provider_support").get();
      print("=========> ${result.data()}");

      Map<String,dynamic>? data=result.data();
      support.value=data!['body'];
      print("=========> ${support.value}");
      otherLoading(false);
    } catch (e) {
      debugPrint("Error Support ");
    }
  }







}