import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrcontacts/model/notification_model.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserNotificationController extends GetxController {
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var loading = false.obs;

  getNotification(bool load) async {
    try {
      if(load){
        loading(true);
      }

      var response = await _firebaseFirestore
          .collection(AppConstants.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(AppConstants.notifications)
          .orderBy("create_at",descending: true)
          .get();
      notificationList.value = List<NotificationModel>.from(
          (response.docs.map((x) => NotificationModel.fromJson(x))));
      notificationList.refresh();
      debugPrint(" get notification list length ${notificationList.length}");
    } catch (e) {
      debugPrint("Opps, Something error get notification list $e");
    } finally {
      if(load){
        loading(false);
      }

    }
  }
}
