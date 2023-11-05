import 'dart:async';

import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Get.offAndToNamed(AppRoute.userSignIn);
    });
    super.initState();
  }
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
        child: const Center(
          child:CustomText(
            text: AppStrings.logo,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }
}
