import 'package:find_worker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemChromeHelper{


 static  enableSystemChrome(){
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(// navigation bar color
       statusBarColor: Colors.white, // status bar color
       systemNavigationBarColor: Colors.black,
       statusBarIconBrightness: Brightness.dark
   ));
 }

 static  blueColorSystemChrome(){
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(// navigation bar color
       statusBarColor: AppColors.blue_100, // status bar color
       systemNavigationBarColor: Colors.black,
       statusBarIconBrightness: Brightness.light
   ));
 }


 static  disableSystemChrome(){
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
     statusBarColor: Colors.transparent,
   ));
 }

}