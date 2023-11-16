import 'package:find_worker/model/hire_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_details/inner_widgets/sp_job_details_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
    
    loading(false);
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
    Fluttertoast.showToast(msg:"Oops,something wrong");
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
     jobDetails.value.status=AppConstants.approved;
     jobDetails.refresh();
     homeController.getHistoryList();
     update();

     debugPrint("=========> Complete Accepted");
   } on Exception catch (e) {
     acceptWorkLoading(false);
     Fluttertoast.showToast(msg:"Oops,something wrong");
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
     jobDetails.value.status=AppConstants.canceled;
     jobDetails.refresh();
     homeController.getHistoryList();
     Get.back();
     update();
     debugPrint("=========> Complete Cancel");
   } on Exception catch (e) {
     cancelWorkLoading(false);
     Fluttertoast.showToast(msg:"Oops,something wrong");
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

     jobDetails.value.status=AppConstants.working;
     print("========> Status Change accept ${jobDetails.value.status}");
     jobDetails.refresh();
     homeController.getHistoryList();
     update();
     debugPrint("=========> Complete Working");

   } on Exception catch (e) {
     startWorkLoading(false);
     Fluttertoast.showToast(msg:"Oops,something wrong");
   }finally{
     startWorkLoading(false);
   }

 }



}