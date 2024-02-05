import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



class ChangeOtpScreen extends StatefulWidget {
  const ChangeOtpScreen({super.key});

  @override
  State<ChangeOtpScreen> createState() => _ChangeOtpScreenState();
}

class _ChangeOtpScreenState extends State<ChangeOtpScreen> {
/*  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    child:const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                      color: AppColors.blue_100,
                    ),
                  ),
                   CustomText(
                    text: AppStrings.oTP.tr,
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
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        text: "We sent a verification code to your email. Please check your email and enter the verification code.",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                        bottom: 32,
                      ),
                      PinCodeTextField(
                        cursorColor: AppColors.black_10,

                        appContext: (context),
                        validator: (value){
                          if (value!.length <= 6) {
                            return null;
                          } else {
                            return "Please enter the OTP code.";
                          }
                        },
                        autoFocus: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 56,
                          fieldWidth: 44,
                          activeFillColor: AppColors.white,
                          selectedFillColor: AppColors.white,
                          inactiveFillColor: AppColors.white,
                          borderWidth: 0.1,
                          errorBorderColor: AppColors.blue_10,
                          selectedColor: AppColors.blue_80,
                          activeColor: AppColors.blue_80,
                          inactiveColor: AppColors.blue_10,
                        ),
                        length: 6,
                        enableActiveFill: true,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            CustomText(
                            text: AppStrings.didNotGetTheCode.tr,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.black_100,
                          ),
                          GestureDetector(
                            onTap: () {
                              /*Get.to(()=> const OtpScreen());*/
                            },
                            child:   CustomText(
                              text: AppStrings.resend.tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.blue_100,

                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                );
              }
          ),
          bottomNavigationBar: BottomNavButton(buttonText: AppStrings.verify.tr, onTap: (){
            Get.toNamed(AppRoute.changeResetPasswordScreen);
          }),
        ));
  }
}