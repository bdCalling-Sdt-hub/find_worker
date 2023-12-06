import 'dart:async';

import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/core/share_pre.dart';
import 'package:find_worker/helper/SystemChromeHelper/system_chrome.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../service_provider/Binding/provider_bottombar_binding.dart';
import '../user/Binding/user_bottom_binding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChromeHelper.disableSystemChrome();
    Timer(const Duration(seconds: 2), ()async{
      var logged= await PrefsHelper.getString(AppConstants.logged);
      if(logged==AppConstants.userType){
        Get.off(UserBottomNavBarScreen(currentIndex: 0),binding:UserBottomNavBinding());
      }else if(logged==AppConstants.serviceProviderType){
        Get.off(SpBottomNavBarScreen(currentIndex: 0),binding:ProviderBottomNavBinding());
      }else{
        Get.offAndToNamed(AppRoute.onboardScreen);
      }
    });
    super.initState();
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   SystemChromeHelper.enableSystemChrome();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F3F3),Color(0xFFCCE0FA),],
          ),
        ),
        child:  Center(
          child: Image.asset(AppIcons.logoImage,height:94,width: 60,fit: BoxFit.fill,),
          // child:CustomText(
          //   text: AppStrings.logo,
          //   fontSize: 16,
          //   fontWeight: FontWeight.w600,
          // ),
        ),
      ),
    ));
  }
}
