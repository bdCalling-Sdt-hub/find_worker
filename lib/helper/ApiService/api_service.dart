import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ApiService {
  static String sentNotificationApi = "https://fcm.googleapis.com/fcm/send";
  static String sendOtp = "https://us-central1-find-worker-80228.cloudfunctions.net/sendOTP";
  static String otpVerify = "https://us-central1-find-worker-80228.cloudfunctions.net/verifyOTP";

  static String serverKey =
      "AAAAL8AScqE:APA91bFojuCLY8dN-dtg6fT5THU1Ypou63HIfrD9pnq2qPkAZUtKdasf_mpmjDDF1QRxn_4SZsYNr8tsDkKBf-9zwLqyqX4MEaI5DBdXywHE0mTSecC_-0264uJsY9zbLw9ikoWiO8R2";

  static Future<dynamic> postNotification(Map<String, dynamic> body) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey'
      };
      var response = await http.post(Uri.parse(sentNotificationApi),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      return 1;
    }
  }

  static Future<dynamic> otpVerifyFunction(Map<String, dynamic> body) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.post(Uri.parse(otpVerify),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        debugPrint("verify error : ${response.body}");
        return response.statusCode;

      }
    } on Exception catch (e) {
      return 1;
    }
  }  static Future<dynamic> sendOtpFunction(Map<String, dynamic> body) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.post(Uri.parse(sendOtp),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      return 1;
    }
  }

 static var uuid=Uuid();
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
 static  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

 //
 static Future<void>  sendNotification({required String content,required  String userRole, required String historyId,required String fcmToken,required String type,required  String receiverId,})async{


    try {
      var id= uuid.v4();
      Map<String, dynamic> notificationBody = {
        "to": fcmToken,
        "mutable_content": true,
        "notification": {
          "title":
          "WoContact",
          "body": content
        },
        "data": {"status":type,"userRole":userRole}
      };

      Map<String,dynamic> body={
        "id":id,
        "sender_id":_firebaseAuth.currentUser!.uid,
        "create_at":DateTime.now(),
        "content":content,
        "history_id":historyId,
        "status":type,
        "seen":AppConstants.unSeen
      };
      await _firebaseFirestore.collection(AppConstants.users).doc(receiverId).collection(AppConstants.notifications).doc(id).set(body);
      await ApiService.postNotification(notificationBody);
    } on Exception catch (e) {
      debugPrint("Opps,Something send notification error $e");
    }

  }




}
