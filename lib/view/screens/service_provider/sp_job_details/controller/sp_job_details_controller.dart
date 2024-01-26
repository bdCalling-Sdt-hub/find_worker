import 'package:wrcontacts/model/hire_model.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_job_details/inner_widgets/sp_job_details_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../helper/ApiService/api_service.dart';


class SpJobDetailsController extends GetxController{


 FirebaseFirestore  firebaseFirestore= FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final homeController = Get.put(SpHomeController());

  Rx<HireModel> jobDetails=HireModel().obs;
  var loading=false.obs;
  
getJobHistory(String jobId) async {
  try {
    loading(true);
    final hireHistoryData = await firebaseFirestore
        .collection(AppConstants.users)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.jobHistory)
        .doc(jobId)
        .get();
        if(hireHistoryData.exists){
          var hireHistory=hireHistoryData.data();
           print(hireHistory!['service_id']);
      final serviceData = await firebaseFirestore
          .collection(AppConstants.services)
          .doc(hireHistory['service_id'])
          .get();
      final userData = await firebaseFirestore
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
              serviceNameArabic: serviceData['category_arabic'],
              uid: hireHistory['hiring_user_id'],
              status: hireHistory['status'],
              createAt: hireHistory['create_at'].toDate(),
              image: serviceData['image'],
              averageRating: userData['average_rating'].toDouble(),
              name: userData['username'],
              address: userData['address'],
              userFcmToken: userData['fcmToken'],
              userRole: userData['role'],
              contact: "${userData['phone_code']} ${userData['phone']}");
         jobDetails.value=hireModel;
         jobDetails.refresh();
        }
      }
        }else{
          Get.back();
          Fluttertoast.showToast(msg:"Job details not found!".tr,toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER);

        }
    Future.delayed(const Duration(seconds:1),(){
      loading(false);
    });

  } catch (e) {
    debugPrint("Oops, Something Wrong $e");
  }
}

var completeLoading=false.obs;

completeService(HireModel hireModel,)async{
  completeLoading(true);
  try {
    await firebaseFirestore
        .collection(AppConstants.users)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.complete});
    await firebaseFirestore
        .collection(AppConstants.users)
        .doc(hireModel.uid)
        .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.complete});
    await ApiService.sendNotification(content:"Great job! The task has been successfully completed.",userRole:hireModel.userRole!, historyId:hireModel.id!, fcmToken:hireModel.userFcmToken!, type:AppConstants.complete, receiverId:hireModel.uid!);

    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context){
          return  const SpJobDetailsAlert();
        }
    );
    jobDetails.value.status=AppConstants.complete;
    jobDetails.refresh();
    homeController.getHistoryList();

  } on Exception catch (e) {
    completeLoading(false);
    Fluttertoast.showToast(msg:"Oops,something wrong".tr);
  }finally{
    completeLoading(false);
  }

}
 var startWorkLoading=false.obs;
 var cancelWorkLoading=false.obs;
 var acceptWorkLoading=false.obs;

 acceptService(HireModel hireModel,)async{
   acceptWorkLoading(true);
   try {
     await firebaseFirestore
         .collection(AppConstants.users)
         .doc(_auth.currentUser!.uid)
         .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.approved});
     await firebaseFirestore
         .collection(AppConstants.users)
         .doc(hireModel.uid)
         .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.approved});
     await ApiService.sendNotification(content:"Your request has been approved. You can now proceed with the next steps.", userRole:hireModel.userRole!, historyId:hireModel.id!, fcmToken:hireModel.userFcmToken!, type:AppConstants.approved, receiverId:hireModel.uid!);

     jobDetails.value.status=AppConstants.approved;
     jobDetails.refresh();
     homeController.getHistoryList();
     update();

     debugPrint("=========> Complete Accepted");
   } on Exception catch (e) {
     acceptWorkLoading(false);
     Fluttertoast.showToast(msg:"Oops,something wrong".tr);
   }finally{
     acceptWorkLoading(false);
   }

 }

 cancelService(HireModel hireModel,)async{
   cancelWorkLoading(true);
   try {
     await firebaseFirestore
         .collection(AppConstants.users)
         .doc(_auth.currentUser!.uid)
         .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.canceled});
     await firebaseFirestore
         .collection(AppConstants.users)
         .doc(hireModel.uid)
         .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.canceled});

     await ApiService.sendNotification(content:"Your request has been canceled.",userRole:hireModel.userRole!, historyId:hireModel.id!, fcmToken:hireModel.userFcmToken!, type:AppConstants.canceled, receiverId:hireModel.uid!);

     jobDetails.value.status=AppConstants.canceled;
     jobDetails.refresh();
     homeController.getHistoryList();
     Get.back();
     update();
     debugPrint("=========> Complete Cancel");
   } on Exception catch (e) {
     cancelWorkLoading(false);
     Fluttertoast.showToast(msg:"Oops,something wrong".tr);
   }finally{
     cancelWorkLoading(false);
   }

 }

 startWorkService(HireModel hireModel,)async{
   startWorkLoading(true);
   try {
     await firebaseFirestore
         .collection(AppConstants.users)
         .doc(_auth.currentUser!.uid)
         .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.working});
     await firebaseFirestore
         .collection(AppConstants.users)
         .doc(hireModel.uid)
         .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.working});
     await ApiService.sendNotification(content:"Work has started on this service", historyId:hireModel.id!,userRole:hireModel.userRole!, fcmToken:hireModel.userFcmToken!, type:AppConstants.working, receiverId:hireModel.uid!);

     jobDetails.value.status=AppConstants.working;
     print("========> Status Change accept ${jobDetails.value.status}");
     jobDetails.refresh();
     homeController.getHistoryList();
     update();
     debugPrint("=========> Complete Working");

   } on Exception catch (e) {
     startWorkLoading(false);
     Fluttertoast.showToast(msg:"Oops,something wrong".tr);
   }finally{
     startWorkLoading(false);
   }

 }



}