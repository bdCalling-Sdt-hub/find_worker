import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrcontacts/model/hire_model.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/share_pre.dart';
import '../../../../../helper/ApiService/api_service.dart';
import '../user_hire_details/inner_widgets/hire_details_alert.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../user_hire_details/inner_widgets/user_service_details_rate_us_alert.dart';

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
          .collection(AppConstants.hireHistory).where("status", whereNotIn: [AppConstants.complete,])
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
      hireList.value = demoList;
      debugPrint("===========> HireList ${hireList.length}");
    } catch (e) {
      debugPrint("Opps,Something error $e");
    } finally {
      if (load) {
        loading(false);
      }
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
        Fluttertoast.showToast(msg:"Hire details not found!",toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER);
      }
      Future.delayed(const Duration(seconds:1),(){
        hireLoading(false);
      });
    } catch (e) {
      debugPrint("Oops, Something Wrong $e");
    }
  }



  var completeLoading=false.obs;

  completeService(HireModel hireModel,)async{
    completeLoading(true);
    try {
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.complete});
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(hireModel.uid)
          .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.complete});
      await ApiService.sendNotification(content:"Great job! The task has been successfully completed.", userRole:hireModel.userRole!,historyId:hireModel.id!, fcmToken:hireModel.userFcmToken!, type:AppConstants.complete, receiverId:hireModel.uid!);


      hireDetails.value.status=AppConstants.complete;
      showDialog(context: Get.context!, builder: (_)=>UserServiceDetailsRateUsAlert(userUid:hireModel.uid!, serviceId:hireModel.serviceId!,));
      hireDetails.refresh();
      getHireList(false);

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



  cancelService(HireModel hireModel,)async{
    cancelWorkLoading(true);
    print("=========> ${hireModel.id}");
    try {
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.canceled});
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(hireModel.uid)
          .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.canceled});
      await ApiService.sendNotification(content:"Your request has been canceled.", historyId:hireModel.id!,userRole:hireModel.userRole!, fcmToken:hireModel.userFcmToken!, type:AppConstants.canceled, receiverId:hireModel.uid!);

      hireDetails.value.status=AppConstants.canceled;
      hireDetails.refresh();
      getHireList(false);
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
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.hireHistory).doc(hireModel.id).update({"status":AppConstants.working});
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(hireModel.uid)
          .collection(AppConstants.jobHistory).doc(hireModel.id).update({"status":AppConstants.working});
      await ApiService.sendNotification(content:"Work has started on this service",userRole:hireModel.userRole!, historyId:hireModel.id!, fcmToken:hireModel.userFcmToken!, type:AppConstants.working, receiverId:hireModel.uid!);


      hireDetails.value.status=AppConstants.working;
      print("========> Status Change accept ${hireDetails.value.status}");
      hireDetails.refresh();
      getHireList(false);
      update();
      debugPrint("=========> Complete Working");

    } on Exception catch (e) {
      startWorkLoading(false);
      Fluttertoast.showToast(msg:"Oops,something wrong");
    }finally{
      startWorkLoading(false);
    }

  }


  var uuid = Uuid();
  var ratingLoading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var rating = 1.0.obs;
  TextEditingController feedbackController = TextEditingController();

  sendReview(String userId, String serviceId) async {
    if (formKey.currentState!.validate()) {
      try {
        ratingLoading(true);
        var id = uuid.v4();
        var userName = await PrefsHelper.getString('userName');
        Map<String, dynamic> body = {
          "id": id,
          "content": feedbackController.text.trim(),
          "uid": _firebaseAuth.currentUser!.uid,
          "rating": rating.value,
          "service_id": serviceId,
          "create_at": DateTime.now(),
          "user_name": userName
        };
        await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(userId)
            .collection(AppConstants.reviews)
            .doc(id)
            .set(body);

        QuerySnapshot reviews = await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(userId)
            .collection(AppConstants.reviews)
            .get();
        double totalRating = 0.0;
        int reviewCount = reviews.docs.length;
        for (var review in reviews.docs) {
          totalRating += review['rating'];
        }
        double averageRating =
        reviewCount > 0 ? totalRating / reviewCount : 0.0;
        await FirebaseFirestore.instance
            .collection(AppConstants.users)
            .doc(userId)
            .update({
          'average_rating': averageRating,
        });

        feedbackController.clear();
        Get.back();
      } on Exception catch (e) {
        debugPrint("Opps error =====> $e");
      } finally {
        ratingLoading(false);
      }
    }
  }


  Future<void> launchPhoneDialer(String contactNumber) async {
    debugPrint("LunchDialer nubmer : $contactNumber");
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (!await UrlLauncher.launchUrl(phoneUri)) {
        UrlLauncher.launchUrl(phoneUri);
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }





}
