import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/model/hire_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../user_hire_details/inner_widgets/hire_details_alert.dart';

class HireController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxList<HireModel> hireList = <HireModel>[].obs;
  var loading = false.obs;


  getHireList(bool load) async {
    try {
      if (load) {
        loading(true);
      }

      final hireHistoryData = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory)
          .where("status", isEqualTo: "Pending")
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
                uid: hireHistory['service_provider_id'],
                status: hireHistory['status'],
                createAt: hireHistory['create_at'].toDate(),
                image: serviceData['image'],
                averageRating: userData['average_rating'],
                name: userData['username'],
                address: userData['address'],
                contact: userData['phone']);
            demoList.add(hireModel);
          }
        }
      }
      hireList.value = demoList;
      debugPrint("===========> HireList ${hireList.length}");
    } catch (e) {
      debugPrint("Opps Error $e");
    } finally {
      if (load) {
        loading(false);
      }
    }
  }

  var completeLoading=false.obs;
  completeService(HireModel hireModel,)async{
    completeLoading(true);
    try {
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":"Complete"});
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(hireModel.uid)
          .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":"Complete"});
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context){
            return  HireDetailsAlert();
          }
      );

    } on Exception catch (e) {
      completeLoading(false);
      Fluttertoast.showToast(msg:"Oops,something wrong");
    }finally{
      completeLoading(false);
    }


  }






}
