import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wocontacts/core/share_pre.dart';
import 'package:wocontacts/helper/AdMob/ad_display.dart';
import 'package:wocontacts/helper/ApiService/api_service.dart';
import 'package:wocontacts/model/hire_model.dart';
import 'package:wocontacts/model/service_by_user_model.dart';
import 'package:wocontacts/model/user_model.dart';
import 'package:wocontacts/utils/app_constents.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_images.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/widgets/custom_button.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
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
import '../../user_hire_list/user_hire_details/user_hire_details_screen.dart';
import '../inner_widgets/user_service_details_hire_now_bottom_modal.dart';

class UserServiceDetailsController extends GetxController
    with GetxServiceMixin {
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
  RxBool isAlreadyHire=false.obs;
  late UserByServiceModel hireServiceModel;
  var hireId = "";
  late UserModel hireUserData;

  hireNow(UserByServiceModel servicedata,UserModel currentUserData) async {
    hireLoading(true);
    start.value = 300;
    try {
      if(!isAlreadyHire.value){
        hireServiceModel=servicedata;
        hireUserData=currentUserData;
      }

      var result = await getCheckTime(hireServiceModel);
      if (result == -1) {
        if(!isAlreadyHire.value){
          await hireDataPost(hireServiceModel, hireUserData);
          timerSystem(hireServiceModel);
        }
      } else {
        current.value = result;
        waitingResponseBottomShit();
      }
      print("======> After Hiring Time $result");
      // await hireDataPost(userdata, number, currentUserData);
    } catch (e) {
      debugPrint("Opps error $e");
      Fluttertoast.showToast(msg: "Oops, Something error!,Please try again".tr);
    } finally {
      hireLoading(false);
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    debugPrint("LunchDialer number : $contactNumber");
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (!await UrlLauncher.launchUrl(phoneUri)) {
        UrlLauncher.launchUrl(phoneUri);
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  Future<void> hireDataPost(UserByServiceModel serviceModel,
      UserModel hireUserData) async {
    try {
      hireLoading(true);
      var id = uuid.v4();
      hireId=id;
      Map<String, dynamic> hireBody = {
        "id": id,
        "service_id": serviceModel.id,
        "service_provider_id": serviceModel.providerUid,
        "service_name": serviceModel.serviceName,
        "status": AppConstants.pending,
        "create_at": DateTime.now()
      };
      Map<String, dynamic> jobBody = {
        "id": id,
        "service_id": serviceModel.id,
        "hiring_user_id": _auth.currentUser!.uid,
        "service_name": serviceModel.serviceName,
        "status": AppConstants.pending,
        "create_at": DateTime.now()
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
      await ApiService.sendNotification(
          content: "Congratulations! You're Hired!",
          userRole: AppConstants.serviceProviderType,
          historyId: id,
          fcmToken: hireUserData.fcmToken!,
          type: AppConstants.pending,
          receiverId: hireUserData.uid!);
      isAlreadyHire(true);
      Fluttertoast.showToast(msg: "Hired Successful".tr);
      debugPrint("Hire Completed");
    } on Exception catch (e) {
      debugPrint("Opps!, Something error  $e ");
      // TODO
    } finally {
      hireLoading(false);
    }
  }
  var cancelLoading=false.obs;
    cancelHire()async{
  try {
    cancelLoading(true);
    await _firebaseFirestore
        .collection(AppConstants.users)
        .doc(_auth.currentUser!.uid)
        .collection(AppConstants.hireHistory)
        .doc(hireId)
        .update({"status": AppConstants.canceled,});
    await _firebaseFirestore
        .collection(AppConstants.users)
        .doc(hireServiceModel.providerUid)
        .collection(AppConstants.jobHistory)
        .doc(hireId)
        .update({"status": AppConstants.canceled,});
    Get.back();
  } finally {
    cancelLoading(false);
  }

}
  Future<int> getCheckTime(UserByServiceModel serviceData) async {
    DateTime fiveMinutesAgo = DateTime.now().subtract(const Duration(minutes: 5));

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
          isAlreadyHire(false);
          Fluttertoast.showToast(msg: "Service Provider Request $result");
          Get.back();
          if(result==AppConstants.approved){
            Get.to(UserHireDetailsScreen(
              hireId:hireId,
            ));
          }
        }
        debugPrint(current.value.toString());
        print("=======>Status Get Result  $result");
      } else {
        print("=======> Not Response timer cancel");
        isAlreadyHire(false);
        current.value = 0;
        _timer?.cancel();
        await cancelHire();
        noResponseBottomShit();
        print("=======> Not Response timer cancel and bottom sheet");// Stop the timer when it reaches 0
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
          if (data['status'] == AppConstants.approved) {
            status = AppConstants.approved;
            print("========>Provider Status Approved");
          } else if (data['status'] == AppConstants.canceled) {
            status = AppConstants.canceled;
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
                Obx(()=>
                   OutlinedButton(
                    onPressed: ()async {
                      _timer?.cancel();
                       start.value = 300; // 5 minutes in seconds
                       current.value = 0;
                    await  cancelHire();
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
                    child:cancelLoading.value? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: AppColors.blue_100,)): Text(
                      "Cancel".tr,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.blue_100,
                          fontWeight: FontWeight.w600),
                    ),
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
                CustomButton(onTap: () {
                  Get.back();
                  hireNow(hireServiceModel, hireUserData);
                }, text: AppStrings.tryAgain.tr),
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
                    "Cancel".tr,
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

  // @override
  // void onReady() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     AdDsiplay().loadInterstitial();
  //   });

  //   super.onReady();
  // }

  // @override
  // void onInit() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     AdDsiplay().loadInterstitial();
  //   });
  //   super.onInit();
  // }
}
