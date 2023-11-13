import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/Controller/setting_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/bottom_nav_button.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../user/user_auth/user_forget_password/user_forget_password_screen.dart';

class SpChangePasswordScreen extends StatefulWidget {
  const SpChangePasswordScreen({super.key});

  @override
  State<SpChangePasswordScreen> createState() => _SpChangePasswordScreenState();
}

class _SpChangePasswordScreenState extends State<SpChangePasswordScreen> {

  final _settingController =Get.put(SpSettingController());

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  CustomAppBar(
        appBarContent:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 18,
                color: AppColors.blue_100,
              ),
            ),
            Text(
              AppStrings.changePassword.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.blue_100,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox()
          ],
        ),
      ),
      body:  LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Current Password',
                      color: AppColors.black_100,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    CustomTextField(
                      isPassword: true,
                      textEditingController:_settingController.currentPassCtrl,
                      textAlign: TextAlign.start,
                      hintText: AppStrings.enterYourPassword.tr,
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
                    const CustomText(
                      text: "New Password",
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
                      textEditingController:_settingController.newPassCtrl,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password Not Be Empty".tr;
                        } else if (_settingController.newPassCtrl.text !=
                            _settingController.confirmPassCtrl.text) {
                          return "Password doesn't match".tr;
                        }
                        return null;
                      },
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.blue_10,
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
                      textEditingController:_settingController.confirmPassCtrl,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your Password'.tr;
                        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(_settingController.confirmPassCtrl.text)) {
                          return "Please use uppercase, lowercase, special character, and number".tr;
                        } else if (value.length < 8) {
                          return "Please use 8 character long password".tr;
                        }
                        return null;
                      },
                      hintText: AppStrings.reEnterYourNewPassword.tr,
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.blue_10,
                      fieldBorderRadius: 8,

                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(const UserForgetPasswordScreen(inAppForget:true,));
                      } ,
                      child:  CustomText(
                        text: AppStrings.forgetPassword.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue_100,
                        top: 16,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
      bottomNavigationBar:Padding(
        padding:  EdgeInsets.only(bottom:54.h,right: 20.w,left: 20.w),
        child: Obx(()=>
           CustomButton(text:AppStrings.save.tr,
          loading: _settingController.loading.value,
          onTap:(){
            if(_formKey.currentState!.validate()){
              _settingController.changePassword(_settingController.currentPassCtrl.text, _settingController.confirmPassCtrl.text);

            }

          },),
        ),
      ),
    );
  }
}