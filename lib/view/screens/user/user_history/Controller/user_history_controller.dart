import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../model/hire_model.dart';
import '../../../../../utils/app_constents.dart';

class UserHistoryController extends GetxController{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxList<HireModel> historyList = <HireModel>[].obs;
  var loading = false.obs;


  getHistoryList(bool load) async {
    try {
      if (load) {
        loading(true);
      }
      final hireHistoryData = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory)
          .where("status", isEqualTo:AppConstants.complete)
          .get();
      List<HireModel> demoList = [];
      for (final hireHistory in hireHistoryData.docs) {
        print(hireHistory['service_id']);
        final serviceData = await _firebaseFirestore
            .collection(AppConstants.services)
            .doc(hireHistory['service_id'])
            .get();
        final userData = await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(hireHistory['service_provider_id'])
            .get();
        if (serviceData.exists) {
          print("print====> ${serviceData['category_name']}");
          if (userData.exists) {
            HireModel hireModel = HireModel(
                id: hireHistory['id'],
                serviceId: hireHistory['service_id'],
                serviceName: serviceData['category_name'],
                serviceNameArabic: serviceData['category_arabic'],
                uid: hireHistory['service_provider_id'],
                status: hireHistory['status'],
                createAt: hireHistory['create_at'].toDate(),
                image: serviceData['image'],
                averageRating: userData['average_rating'].toDouble(),
                name: userData['username'],
                address: userData['address'],
                userFcmToken: userData['fcmToken'],
                userRole: userData['role'],
                contact: "${userData['phone_code']} ${userData['phone']}");
            demoList.add(hireModel);
          }
        }
      }
      demoList.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      historyList.value = demoList;
      debugPrint("===========> historyList  ${historyList.length}");
    } catch (e) {
      debugPrint("Oops, Something Wrong $e");
    } finally {
      if (load) {
        loading(false);
      }
    }
  }
var removeLoading=false.obs;

  removeJobHistory(String id,)async{
    removeLoading(true);
    try {
      await _firebaseFirestore.collection(AppConstants.users).doc(_firebaseAuth.currentUser!.uid).collection(AppConstants.hireHistory).doc(id).delete();
    await getHistoryList(false);
      historyList.refresh();
      Get.back();
      Get.back();
    } on Exception catch (e) {
      debugPrint("======>Oops, Something is wrong");
    }finally{
      removeLoading(false);
    }

  }




  Rx<HireModel> hireDetails=HireModel().obs;
  var hireLoading=false.obs;

  getHireDetails(String jobId) async {
    try {
      hireLoading(true);
      final hireHistoryData = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory)
          .doc(jobId)
          .get();
      if(hireHistoryData.exists){
        var hireHistory=hireHistoryData.data();
        print(hireHistory!['service_id']);
        print(hireHistory['service_id']);

        final serviceData = await _firebaseFirestore
            .collection(AppConstants.services)
            .doc(hireHistory['service_id'])
            .get();
        final userData = await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(hireHistory['service_provider_id'])
            .get();
        if (serviceData.exists) {
          print("print====> ${serviceData['category_name']}");
          if (userData.exists) {
            HireModel hireModel = HireModel(
                id: hireHistory['id'],
                serviceId: hireHistory['service_id'],
                serviceName: serviceData['category_name'],
                serviceNameArabic: serviceData['category_arabic'],
                uid: hireHistory['service_provider_id'],
                status: hireHistory['status'],
                createAt: hireHistory['create_at'].toDate(),
                image: serviceData['image'],
                averageRating: userData['average_rating'].toDouble(),
                name: userData['username'],
                address: userData['address'],
                userFcmToken: userData['fcmToken'],
                userRole: userData['role'],
                contact: "${userData['phone_code']} ${userData['phone']}");
            hireDetails.value=hireModel;
            hireDetails.refresh();
          }
        }
      }else{
        Get.back();
        Fluttertoast.showToast(msg:"Hire details not found!".tr,toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER);
      }
      Future.delayed(const Duration(seconds:1),(){
        hireLoading(false);
      });

    } catch (e) {
      debugPrint("Oops, Something Wrong $e");
    }
  }






}