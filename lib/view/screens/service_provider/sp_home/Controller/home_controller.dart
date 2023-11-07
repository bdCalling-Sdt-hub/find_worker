import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../model/service_model.dart';
import '../../../../../model/user_model.dart';
import '../../../../../utils/app_constents.dart';

class SpHomeController extends GetxController{
@override
  void onInit() {
  getService();
  super.onInit();
  }
  var loading=false.obs;
  FirebaseFirestore  firebaseStorage= FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxList<ServiceModel> serviceList= <ServiceModel> [].obs;

  getService()async{
    loading(true);
    try {
      var result= await  firebaseStorage.collection(AppConstants.services).where("provider_uid",isEqualTo:_auth.currentUser!.uid).get();
      serviceList.value= List<ServiceModel>.from(result.docs.map((x) => ServiceModel.fromJson(x)));
      debugPrint("========> Service Length = ${serviceList.length}");
      serviceList.refresh();
    await  getUserData();

    } on Exception catch (e) {
      loading(false);
    }finally{
      loading(false);
    }
  }

  Rx<UserModel> userData=UserModel().obs;

 Future<void> getUserData()async{

    DocumentSnapshot data = await firebaseStorage.collection(AppConstants.users).doc(_auth.currentUser!.uid).get();
  userData.value = UserModel.fromMap(data);
    userData.refresh();

  }









}