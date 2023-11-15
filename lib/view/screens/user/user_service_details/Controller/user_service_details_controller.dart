import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/core/share_pre.dart';
import 'package:find_worker/helper/ApiService/api_service.dart';
import 'package:find_worker/model/hire_model.dart';
import 'package:find_worker/model/service_by_user_model.dart';
import 'package:find_worker/model/user_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:uuid/uuid.dart';

import '../../../../../model/review_model.dart';
import '../../../../../utils/app_colors.dart';
import '../inner_widgets/user_service_details_hire_now_bottom_modal.dart';

class UserServiceDetailsController extends GetxController {
  var rating = 1.0.obs;
  TextEditingController feedbackController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var uuid = Uuid();
  var ratingLoading = false.obs;
  var hireLoading = false.obs;
  var loading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<ReviewModel> topReviewList = <ReviewModel>[].obs;

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

  getTopReviews(String userId) async {
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
        final uid = reviewData['uid'];

        final userData = await _firebaseFirestore
            .collection(AppConstants.users)
            .doc(uid)
            .get();

        if (userData.exists) {
          reviewData["user_name"] = userData['username'];
          demoReviewsList.add(ReviewModel.fromJson(reviewData));
        }
      }
      demoReviewsList.sort((a, b) => b.rating!.compareTo(a.rating!));
      debugPrint("TopReview List Length : ${topReviewList.length}");
      topReviewList.value = demoReviewsList;
      topReviewList.refresh();
    } on Exception catch (e) {
      debugPrint("Opps error $e");
    } finally {
      loading(false);
    }
  }

  Timer? _timer;

  RxInt start = 300.obs; // 5 minutes in seconds
  RxInt current = 0.obs;

  hireNow(UserByServiceModel servicedata, String number,
      UserModel currentUserData) async {
    hireLoading(true);
    start.value = 300;
    try {
      var result = await getCheckTime(servicedata);
      if (result == -1) {
        await hireDataPost(servicedata, number, currentUserData);
        timerSystem(servicedata);
      } else {
        current.value = result;
        timerSystem(servicedata);
      }
      print("======> After Hiring Time $result");
      // await hireDataPost(userdata, number, currentUserData);
    } catch (e) {
      debugPrint("Opps error $e");
      Fluttertoast.showToast(msg: "Oops, Something error!,Please try again");
    } finally {
      hireLoading(false);
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (!await UrlLauncher.launchUrl(phoneUri)) {
        UrlLauncher.launchUrl(phoneUri);
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  Future<void> hireDataPost(UserByServiceModel serviceModel, String number,
      UserModel currentUserData) async {
    try {
      var id = uuid.v4();
      Map<String, dynamic> hireBody = {
        "id": id,
        "service_id": serviceModel.id,
        "service_provider_id": serviceModel.providerUid,
        "service_name": serviceModel.serviceName,
        "status": "Pending",
        "create_at": DateTime.now()
      };
      Map<String, dynamic> jobBody = {
        "id": id,
        "service_id": serviceModel.id,
        "hiring_user_id": _auth.currentUser!.uid,
        "service_name": serviceModel.serviceName,
        "status": "Pending",
        "create_at": DateTime.now()
      };
      Map<String, dynamic> body = {
        "to": currentUserData.fcmToken,
        "mutable_content": true,
        "notification": {
          "title":
              "New Job Request : ${currentUserData.userName} Has Hired You!",
          "body":
              "Great news! ${currentUserData.userName}  has hired you for a job. They trust your skills and are looking forward to your service."
        },
        "data": {"body": ""}
      };
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_auth.currentUser!.uid)
          .collection(AppConstants.hireHistory)
          .doc(id)
          .set(hireBody);
      await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(serviceModel.providerUid)
          .collection(AppConstants.jobHistory)
          .doc(id)
          .set(jobBody);
      await ApiService.postNotification(body);
      debugPrint("Hire Completed");
    } on Exception catch (e) {
      debugPrint("Opps!, Something error  $e ");

      // TODO
    }
  }

  Future<int> getCheckTime(UserByServiceModel serviceData) async {
    DateTime fiveMinutesAgo = DateTime.now().subtract(Duration(minutes: 5));

    print("Service Id ====> ${serviceData.id}");

    try {
      final result = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_auth.currentUser!.uid)
          .collection(AppConstants.hireHistory)
          .where("create_at", isGreaterThanOrEqualTo: fiveMinutesAgo)
          .get();
      if (result.docs.isNotEmpty) {
        var timeWaiting = (-1);
        DateTime nowDateTime = DateTime.now();
        for (QueryDocumentSnapshot document in result.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if (data['service_id'] == serviceData.id) {
            DateTime dateTime = data['create_at'].toDate();
            Duration difference = nowDateTime.difference(dateTime);
            timeWaiting = difference.inSeconds;
          }
        }
        print("Hire just time 5 minute");
        return timeWaiting;
      } else {
        print("No Hire just time 5 minute");
        return -1;
      }
    } on Exception catch (e) {
      print("Oops, Something error $e");
      return -1;
    }
  }

  timerSystem(UserByServiceModel serviceData) async {
    waitingResponseBottomShit();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (current.value < 300) {
        current.value += 5;
        var result = await getHireResponseStatus(serviceData);
        if (result.isNotEmpty) {
          _timer?.cancel();
          current.value = 0;
          Fluttertoast.showToast(msg: "Service Provider Request $result");
          Get.back();
        }
        debugPrint(current.value.toString());
        print("=======>Status Get Result  $result");
      } else {
        _timer?.cancel();
        Get.back();
        noResponseBottomShit(); // Stop the timer when it reaches 0
      }
    });
    // waitingResponseBottomShit();
  }

  Future<String> getHireResponseStatus(UserByServiceModel serviceData) async {
    DateTime fiveMinutesAgo =
        DateTime.now().subtract(const Duration(minutes: 5));

    print("Service Id ====> ${serviceData.id}");

    try {
      final result = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_auth.currentUser!.uid)
          .collection(AppConstants.hireHistory)
          .where("create_at", isGreaterThanOrEqualTo: fiveMinutesAgo)
          .get();
      String status = "";
      if (result.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in result.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if (data['status'] == "Approved") {
            status = "Approved";
            print("========>Provider Status Approved");
          } else if (data['status'] == "Cancel") {
            status = "Cancel";
            print("========>Provider Status Cancel");
          }
        }
        print("========>Provider Status return");
        return status;
      } else {
        print("========>Provider Status Get Status");
        return status;
      }
    } on Exception catch (e) {
      print("Oops, Something  error $e");
      return "";
    }
  }

  waitingResponseBottomShit() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r)),
                color: Colors.white,
                border: Border.all(color: AppColors.blue_100, width: 1)),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.waitingForProvidersResponse.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: AppColors.blue_100,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Obx(
                  () => LinearProgressIndicator(
                    minHeight: 8.h,
                    borderRadius: BorderRadius.circular(100.r),
                    value: current.value / start.value,
                    backgroundColor: const Color(0xFFE2E2E2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF0668E3).withOpacity(0.6)),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 56.h)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r))),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: AppColors.blue_100,
                          width: 1.0,
                          style: BorderStyle.solid))),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.blue_100,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        });
  }

  noResponseBottomShit() {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r)),
                color: Colors.white,
                border: Border.all(color: AppColors.blue_100, width: 1)),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomImage(
                  imageSrc: AppIcons.exclamationIcon,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppStrings.noResponse.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: AppColors.blue_100,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(onTap: () {}, text: AppStrings.tryAgain.tr),
                SizedBox(
                  height: 16.h,
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 56.h)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r))),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: AppColors.blue_100,
                          width: 1.0,
                          style: BorderStyle.solid))),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.blue_100,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
