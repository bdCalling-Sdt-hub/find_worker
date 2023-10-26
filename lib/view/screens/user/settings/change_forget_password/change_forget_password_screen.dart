import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/bottom_nav_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';


class ChangeForgetPasswordScreen extends StatefulWidget {
  const ChangeForgetPasswordScreen({super.key});

  @override
  State<ChangeForgetPasswordScreen> createState() => _ChangeForgetPasswordScreenState();
}

class _ChangeForgetPasswordScreenState extends State<ChangeForgetPasswordScreen> {
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
                  const CustomText(
                    text: AppStrings.forgetPassword,
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
                      const CustomText(
                        textAlign: TextAlign.start,
                        text: AppStrings.enterYourEmailAddressToVerifyOTP,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                      ),
                      const CustomText(
                        text: AppStrings.email,
                        color: AppColors.black_100,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        top: 20,
                        bottom: 8,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.start,
                        hintText: AppStrings.enterYourEmail,
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
          bottomNavigationBar: BottomNavButton(buttonText: 'Send OTP', onTap: (){
            Get.toNamed(AppRoute.changeOtpScreen);
          }),
        ));
  }
}