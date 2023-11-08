import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/core/share_pre.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../model/review_model.dart';

class UserServiceDetailsController extends GetxController {
  var rating = 1.0.obs;
  TextEditingController feedbackController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var uuid = Uuid();
  var ratingLoading = false.obs;
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
}
