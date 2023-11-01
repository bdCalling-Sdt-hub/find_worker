import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/bottom_nav_button.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SpChangeForgetPasswordScreen extends StatefulWidget {
  const SpChangeForgetPasswordScreen({super.key});

  @override
  State<SpChangeForgetPasswordScreen> createState() => _SpChangeForgetPasswordScreenState();
}

class _SpChangeForgetPasswordScreenState extends State<SpChangeForgetPasswordScreen> {
/*  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar:  CustomAppBar(
              appBarContent: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                      color: AppColors.blue_100,
                    ),
                  ),
                   CustomText(
                    text: 'Forget Password'.tr,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue_100,
                  ),
                  const SizedBox()
                ],
              )),
          body: LayoutBuilder(
              builder: (BuildContext context,BoxConstraints constraints){
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Enter your E-mail address to verify OTP'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                      ),
                        CustomText(
                        text: 'Email'.tr,
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        top: 20,
                        bottom: 8,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.start,
                        hintText:'Enter your email'.tr,
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_40),
                        inputTextStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.black_100),
                        fieldBorderColor: AppColors.blue_10,
                        fieldBorderRadius: 8,

                      ),

                    ],
                  ),
                );
              }
          ),
          bottomNavigationBar: BottomNavButton(buttonText: 'Get OTP'.tr, onTap: (){
            Get.toNamed(AppRoute.spChangeOtpScreen);
          }),
        ));
  }
}