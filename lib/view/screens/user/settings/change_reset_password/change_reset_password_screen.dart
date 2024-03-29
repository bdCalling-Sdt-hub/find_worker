


import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:wocontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/custom_back.dart';


class ChangeResetPasswordScreen extends StatefulWidget {
  const ChangeResetPasswordScreen({super.key});

  @override
  State<ChangeResetPasswordScreen> createState() => _ChangeResetPasswordScreenState();
}

class _ChangeResetPasswordScreenState extends State<ChangeResetPasswordScreen> {
  /* @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppStrings.resetPassword.tr),
        leading: CustomBack(),
      ),
      // appBar: CustomAppBar(
      //     appBarContent: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         GestureDetector(
      //           onTap:(){
      //             Get.back();
      //           },
      //           child:  const Icon(
      //             Icons.arrow_back_ios_new_outlined,
      //             size: 18,
      //             color: AppColors.black_100,
      //           ),
      //         ),
      //          CustomText(
      //           text: AppStrings.resetPassword.tr,
      //           fontSize: 18,
      //           fontWeight: FontWeight.w500,
      //           color: AppColors.blue_100,
      //         ),
      //         const SizedBox()
      //       ],
      //     )),
      body:  LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CustomText(
                    text: "New Password".tr,
                    color: AppColors.black_100,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    top: 16,
                    bottom: 8,
                  ),
                  CustomTextField(
                    isPassword: true,
                    textAlign: TextAlign.start,
                    hintText: "Enter your new password",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_40),
                    inputTextStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black_100),
                    fieldBorderColor: AppColors.black_10,
                    fieldBorderRadius: 8,

                  ),
                   CustomText(
                    text: AppStrings.confirmPassword.tr,
                    color: AppColors.black_100,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    top: 16,
                    bottom: 8,
                  ),
                  CustomTextField(
                    isPassword: true,
                    textAlign: TextAlign.start,
                    hintText: 'Re-write password',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_40),
                    inputTextStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black_100),
                    fieldBorderColor: AppColors.black_10,
                    fieldBorderRadius: 8,

                  ),
                ],
              ),
            );
          }
      ),
      bottomNavigationBar: BottomNavButton(buttonText: 'Update', onTap: (){
        Get.toNamed(AppRoute.settingScreen);
      }),
    );
  }
}