import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ApiService {
  static String sentNotificationApi = "https://fcm.googleapis.com/fcm/send";
  static String serverKey =
      "AAAARBLi-U8:APA91bG5wFkcur9UaNnpOcVjkDQwaPHQt3Z1vekct5L_8i6-28J4eQXLxelwS1n3xTHS47tuWPgL90pOK3YzEE60Z1iGXgZGYpNCJJ2kmdAFhdMhrAKOU3vidxcp1MdrfOyrce_Aq_2Y";

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
          "Find Worker",
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
