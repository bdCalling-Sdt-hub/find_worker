
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService{

      static String sentNotificationApi="https://fcm.googleapis.com/fcm/send";
      static String serverKey="AAAARBLi-U8:APA91bG5wFkcur9UaNnpOcVjkDQwaPHQt3Z1vekct5L_8i6-28J4eQXLxelwS1n3xTHS47tuWPgL90pOK3YzEE60Z1iGXgZGYpNCJJ2kmdAFhdMhrAKOU3vidxcp1MdrfOyrce_Aq_2Y";


  static Future<dynamic>   postNotification(Map<String,dynamic> body)async{
          try {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey'
  };
    var response=   await http.post(Uri.parse(sentNotificationApi),headers: headers,body:json.encode(body));
      if(response.statusCode==200){
        return response.body;
      }else{
        return response.statusCode;
      }
} on Exception catch (e) {
  return 1;
}
          





      }










}