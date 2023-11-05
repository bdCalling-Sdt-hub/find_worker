import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController{
    var userName="".obs;
    var userRole="".obs;
    var uid="".obs;
    var image="".obs;
    var authType="".obs;
    setData({required String userNameD,
      required String userRoleD,
      required String uidD,required String imageD,required String authTypeD})async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userName", userNameD);
      prefs.setString("userRole", userRoleD);
      prefs.setString("uid", uidD);
      prefs.setString("image", imageD);
      prefs.setString("authType", authTypeD);
      userName.value=userNameD;
      authType.value=authTypeD;
      userRole.value=userRoleD;
      image.value=imageD;
      uid.value=uidD;
    }
    getData()async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userName.value=   prefs.getString("userName",)??"";
      authType.value= prefs.getString("authType",)??"";
      userRole.value=prefs.getString("userRole", )??"";
      image.value=     prefs.getString("image", )??"";
      uid.value=  prefs.getString("uid", )??"";
    }
















}