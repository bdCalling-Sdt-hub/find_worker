import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../../model/user_model.dart';
import '../../../../../utils/app_constents.dart';

class SpProfileController extends GetxController {

  SpHomeController spHomeController=Get.put(SpHomeController());

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<UserModel> userData = UserModel().obs;
  var loading = false.obs;

  getProfile() async {
    try {
      loading(true);
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(_auth.currentUser!.uid)
          .get();
      if (data.exists) {
        UserModel demoData = UserModel.fromMap(data);
        userData.value = demoData;
        debugPrint("==========> Get Profile Data ${userData.value.userName}");
        userData.refresh();
      }
      loading(false);
    } on Exception catch (e) {
      debugPrint("Oops, something error $e");
    }
  }

  /// <----------------------- Edit Profile ------------------>
  ///  text field controller edit profile
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController dobDayCtrl = TextEditingController();
  TextEditingController dobMonthCtrl = TextEditingController();
  TextEditingController dobYearCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  List<String> genderList = ["Male", "Female", "Others"];
  var selectGender = (-1).obs;
  var phoneCode = "".obs;

  setData() {
    imagePath.value = "";
    nameCtrl.text = userData.value.userName ?? "";
    dobDayCtrl.text = userData.value.dob!.day.toString() ?? "";
    dobMonthCtrl.text = userData.value.dob!.month.toString() ?? "";
    dobYearCtrl.text = userData.value.dob!.year.toString() ?? "";
    phoneCtrl.text = userData.value.phone ?? "";
    addressCtrl.text = userData.value.address ?? "";
    phoneCode.value = userData.value.phoneCode ?? "";
    emailCtrl.text= userData.value.email ?? "";
    for (int i = 0; i < genderList.length; i++) {
      if (genderList[i] == userData.value.gender) {
        selectGender.value = i;
      }
    }
  }

  final ImagePicker picker = ImagePicker();
  late XFile? image;
  var imagePath = "".obs;
  var uuid = const Uuid();

  picImage(ImageSource imageSource) async {
    try {
      image = await picker.pickImage(source: imageSource);
      if (image != null) {
        imagePath.value = image!.path;
      }
    } on Exception catch (e) {
      print("Pic Image error ");
    }
  }

  updateProfile() async {
    loading(true);

    try {
      var url = "";
      if (imagePath.isNotEmpty) {
        url = await uploadImage();
      }

      Map<String, dynamic> data = {
        'username': nameCtrl.text,
        'dob': DateTime(int.parse(dobYearCtrl.text),
            int.parse(dobMonthCtrl.text), int.parse(dobDayCtrl.text)),
        'phone': phoneCtrl.text,
        'address': addressCtrl.text,
        'imageSrc': imagePath.isNotEmpty ? url : userData.value.imageSrc,
        'gender': genderList[selectGender.value],
        'phone_code': phoneCode.value,
        'email':emailCtrl.text,
      };
      await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(_auth.currentUser!.uid)
          .update(data);
      await getProfile();
      await  spHomeController.getUserData();
      Get.back();
      Fluttertoast.showToast(msg: "Profile update complete!".tr,toastLength: Toast.LENGTH_LONG);
    } on Exception catch (e) {
      debugPrint("Update Profile error $e");
      Fluttertoast.showToast(msg: "Oops!, Profile update something error!".tr);
    } finally {
      loading(false);
    }
  }

  Future<String> uploadImage() async {
    var url = "";
    await FirebaseStorage.instance
        .ref()
        .child("Profile")
        .child(_auth.currentUser!.uid)
        .putFile(
        File(imagePath.value), SettableMetadata(contentType: "image/jpeg"))
        .then((value) async {
      var d = await value.ref.getDownloadURL();
      print("Image link is $d");
      url = d;
    });
    return url;
  }
}
