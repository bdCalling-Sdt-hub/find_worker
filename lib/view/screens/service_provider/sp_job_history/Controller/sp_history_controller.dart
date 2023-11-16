import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../model/hire_model.dart';
import '../../../../../utils/app_constents.dart';

class SpHistoryController extends GetxController{


  @override
  void onInit() {
    getHistoryList(true);
    super.onInit();
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxList<HireModel> historyList = <HireModel>[].obs;
  Rx<HireModel> jobDetails=HireModel().obs;
  var loading = false.obs;

  getHistoryList(bool load) async {
    try {
      if (load) {
        loading(true);
      }
      final hireHistoryData = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.jobHistory)
          .where("status", whereIn: [AppConstants.complete, AppConstants.canceled,])
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
            .doc(hireHistory['hiring_user_id'])
            .get();
        if (serviceData.exists) {
          print("print====> ${serviceData['category_name']}");
          if (userData.exists) {
            HireModel hireModel = HireModel(
                id: hireHistory['id'],
                serviceId: hireHistory['service_id'],
                serviceName: serviceData['category_name'],
                uid: hireHistory['hiring_user_id'],
                status: hireHistory['status'],
                createAt: hireHistory['create_at'].toDate(),
                image: serviceData['image'],
                averageRating: userData['average_rating'].toDouble(),
                name: userData['username'],
                address: userData['address'],
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

  removeJobHistory(String id)async {
    removeLoading(true);
    try {
      await _firebaseFirestore.collection(AppConstants.users).doc(
          _firebaseAuth.currentUser!.uid)
          .collection(AppConstants.jobHistory)
          .doc(id)
          .delete();
     await getHistoryList(false);
      Get.back();
      Get.back();
    } on Exception catch (e) {
      Fluttertoast.showToast(msg:"Oops, Something is wrong");
      debugPrint("======>Oops, Something is wrong");
    } finally {
      removeLoading(false);
    }
  }


  var getJobHistoryDetailsLoading=false.obs;

  getJobHistoryDetails(String jobId) async {
    try {
      getJobHistoryDetailsLoading(true);
      final hireHistoryData = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.jobHistory)
          .doc(jobId)
          .get();
      if(hireHistoryData.exists){
        var hireHistory=hireHistoryData.data();
        print(hireHistory!['service_id']);
        final serviceData = await _firebaseFirestore
            .collection(AppConstants.services)
            .doc(hireHistory['service_id'])
            .get();
        final userData = await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(hireHistory['hiring_user_id'])
            .get();
        if (serviceData.exists) {
          print("print====> ${serviceData['category_name']}");
          if (userData.exists) {
            HireModel hireModel = HireModel(
                id: hireHistory['id'],
                serviceId: hireHistory['service_id'],
                serviceName: serviceData['category_name'],
                uid: hireHistory['hiring_user_id'],
                status: hireHistory['status'],
                createAt: hireHistory['create_at'].toDate(),
                image: serviceData['image'],
                averageRating: userData['average_rating'].toDouble(),
                name: userData['username'],
                address: userData['address'],
                contact: "${userData['phone_code']} ${userData['phone']}");
            jobDetails.value=hireModel;
            jobDetails.refresh();
          }
        }
      }
      getJobHistoryDetailsLoading(false);
    } catch (e) {
      debugPrint("Oops, Something Wrong $e");
    }
  }



  }