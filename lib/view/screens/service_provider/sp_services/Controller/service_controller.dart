import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/model/service_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_constents.dart';

class ServiceController extends GetxController{

var loading=false.obs;
FirebaseFirestore  firebaseStorage= FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
  RxList<ServiceModel> serviceList= <ServiceModel> [].obs;

getService()async{
    loading(true);
    try {
      var result= await  firebaseStorage.collection(AppConstants.services).where("provider_uid",isEqualTo:auth.currentUser!.uid).get();
      serviceList.value= List<ServiceModel>.from(result.docs.map((x) => ServiceModel.fromJson(x)));
      debugPrint("========> Service Length = ${serviceList.length}");
      serviceList.refresh();
      update();
    } on Exception catch (e) {
      loading(false);
    }finally{
      loading(false);
    }
  }






}