import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/core/share_pre.dart';
import 'package:find_worker/model/service_by_user_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:uuid/uuid.dart';

import '../../../../../model/review_model.dart';

class UserServiceDetailsController extends GetxController {
  var rating = 1.0.obs;
  TextEditingController feedbackController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var uuid = Uuid();
  var ratingLoading = false.obs;
  var hireLoading=false.obs;
  var loading=false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<ReviewModel> topReviewList=<ReviewModel>[].obs;

  sendReview(String userId, String serviceId) async {
    if (formKey.currentState!.validate()) {
      try {
        ratingLoading(true);
        var id = uuid.v4();
        var userName = await PrefsHelper.getString('userName');
        Map<String, dynamic> body = {
          "id": id,
          "content": feedbackController.text.trim(),
          "uid": _auth.currentUser!.uid,
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


  getTopReviews(String userId)async{
    loading(true);
    try {
      final reviews = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(userId)
          .collection(AppConstants.reviews)
          .get();

      List<ReviewModel> demoReviewsList = [];
      for (final review in reviews.docs) {
        final reviewData = review.data();
        final uid=reviewData['uid'];

    final userData=    await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(uid).get();

        if(userData.exists){
          reviewData["user_name"]=userData['username'];
          demoReviewsList.add(ReviewModel.fromJson(reviewData));
        }
      }
      demoReviewsList.sort((a, b) => b.rating!.compareTo(a.rating!));
      debugPrint("TopReview List Length : ${topReviewList.length}");
      topReviewList.value=demoReviewsList;
      topReviewList.refresh();
    } on Exception catch (e) {
     debugPrint("Opps error $e");
    }finally{
      loading(false);
    }
  }
  
  hireNow(UserByServiceModel userdata,String number)async{


    hireLoading(true);

    try {
      var id= uuid.v4();
        Map<String ,dynamic> hireBody={
          "id":id,
          "service_id" :userdata.serviceId,
          "service_provider_id":userdata.providerUid,
          "service_name":userdata.serviceName,
          "status":"Pending",
          "create_at":DateTime.now()
        };
        Map<String ,dynamic> jobBody={
          "id":id,
          "service_id" :userdata.serviceId,
          "hiring_user_id":_auth.currentUser!.uid,
          "service_name":userdata.serviceName,
          "status":"Pending",
          "create_at":DateTime.now()
        };

      await _firebaseFirestore.collection(AppConstants.users).doc(_auth.currentUser!.uid).collection(AppConstants.hireHistory).doc(id).set(hireBody);
      await _firebaseFirestore.collection(AppConstants.users).doc(userdata.providerUid).collection(AppConstants.jobHistory).doc(id).set(jobBody);

      debugPrint("Hire Completed");
      launchPhoneDialer(number);

    }catch (e){
      debugPrint("Opps error $e");
    } finally {
      hireLoading(false);
    }

  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (!await UrlLauncher.launchUrl(phoneUri)){
        UrlLauncher.launchUrl(phoneUri);
      }
    } catch (error) {
      throw("Cannot dial");
    }
  }

  
}
