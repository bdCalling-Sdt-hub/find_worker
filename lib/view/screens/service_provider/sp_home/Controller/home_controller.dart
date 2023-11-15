import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../model/hire_model.dart';
import '../../../../../model/service_model.dart';
import '../../../../../model/user_model.dart';
import '../../../../../utils/app_constents.dart';
import '../../../user/user_hire_list/user_hire_details/inner_widgets/hire_details_alert.dart';
import '../../sp_job_details/inner_widgets/sp_job_details_alert.dart';

class SpHomeController extends GetxController{
@override
  void onInit() {
  getData(true);
  super.onInit();
  }
  var loading=false.obs;
  var status= false.obs;
  FirebaseFirestore  firebaseFirestore= FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxList<ServiceModel> serviceList= <ServiceModel> [].obs;
  RxList<HireModel> historyList = <HireModel>[].obs;

  getData(bool load)async{
    if(load){
      loading(true);
    }
    await getTokenAndUpdate();
    await getService();
    await getHistoryList();
    await getUserData();
    if(load){
      loading(false);
    }
  }
getTokenAndUpdate()async{
  try {
    var token= await FirebaseMessaging.instance.getToken();
    print("======> Get Fcm Token $token");
    FirebaseFirestore  firebaseFirestore= FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await firebaseFirestore.collection(AppConstants.users).doc(_auth.currentUser!.uid).update({"fcmToken":token});
  } on Exception catch (e) {
    debugPrint("Oops error $e");
  }


}



  getService()async{
    try {
      var result= await  firebaseFirestore.collection(AppConstants.services).where("provider_uid",isEqualTo:_auth.currentUser!.uid).get();
      serviceList.value= List<ServiceModel>.from(result.docs.map((x) => ServiceModel.fromJson(x)));
      debugPrint("========> Service Length = ${serviceList.length}");
      serviceList.refresh();
    } on Exception catch (e) {
     debugPrint("======>Oops, Something error $e");
    }
  }

  Rx<UserModel> userData=UserModel().obs;

 Future<void> getUserData()async{
    DocumentSnapshot data = await firebaseFirestore.collection(AppConstants.users).doc(_auth.currentUser!.uid).get();
  userData.value = UserModel.fromMap(data);
  status.value=userData.value.status=="Online";
    userData.refresh();
  }
  Future<void> updateStatusData()async{
        try {
          var inActive= status.value?"Offline":"Online";
                 await firebaseFirestore.collection(AppConstants.users).doc(_auth.currentUser!.uid).update({"status":inActive});
                 status.value=!status.value;
        } on Exception catch (e) {
          debugPrint("Oops error $e");
        }

  }







getHistoryList() async {
  try {
    final hireHistoryData = await firebaseFirestore
        .collection(AppConstants.users)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.jobHistory)
        .where("status", whereIn: [AppConstants.pending, AppConstants.approved])
        .get();
    List<HireModel> demoList = [];

    for (final hireHistory in hireHistoryData.docs) {
      print(hireHistory['service_id']);
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
          demoList.add(hireModel);
        }
      }
    }
    demoList.sort((a, b) => b.createAt!.compareTo(a.createAt!));
    historyList.value = demoList;
    debugPrint("===========> historyList  ${historyList.length}");
  } catch (e) {
    debugPrint("Oops, Something Wrong $e");
  }
}




}