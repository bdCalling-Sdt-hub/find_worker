import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';

import 'package:wrcontacts/view/widgets/buttons/custom_button.dart';
import 'package:wrcontacts/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:wrcontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({super.key});

  @override
  State<UserSignIn> createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  final String userType = Get.arguments;

  final loginFormKey = GlobalKey<FormState>();
  final _authController = Get.put(AuthenticationController());
  @override
  void initState() {
    _authController.passwordController.clear();
    _authController.usernameController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: GetBuilder<AuthenticationController>(builder: (controller) {
          return Scaffold(
              body: Container(
            padding:
                const EdgeInsets.only(top: 44, left: 20, right: 20, bottom: 24),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF3F3F3),
                  Color(0xFFCCE0FA),
                ],
              ),
            ),
            child: SingleChildScrollView(
                child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const CustomText(
                    text: AppStrings.welcomeToFindWorker,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    bottom: 30,
                  ),
                  // Image.asset(AppIcons.logoImage,height:94,width: 60,fit: BoxFit.fill,),
                  const SizedBox(
                    height: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const CustomText(
                      //   text: AppStrings.email,
                      //   fontWeight: FontWeight.w500,
                      //   bottom: 8,
                      // ),
                      // CustomTextField(
                      //   textEditingController:
                      //       controller.usernameController,
                      //   textAlign: TextAlign.start,
                      //   hintText: AppStrings.enterYourEmail,
                      //   hintStyle: GoogleFonts.montserrat(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //       color: AppColors.black_40),
                      //   inputTextStyle: GoogleFonts.poppins(
                      //       color: AppColors.black_100),
                      //   fieldBorderColor: AppColors.blue_10,
                      //   fieldBorderRadius: 8,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please enter your email".tr;
                      //     } else if (!RegExp(
                      //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //         .hasMatch(
                      //             controller.usernameController.text)) {
                      //       return "Please enter your valid email".tr;
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      const CustomText(
                        text: AppStrings.phoneNumber,
                        fontWeight: FontWeight.w500,
                        top: 16,
                        bottom: 8,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        textEditingController: controller.phoneController,
                        isPassword: false,
                        textAlign: TextAlign.start,
                        hintText: AppStrings.phoneNumber,
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_40),
                        inputTextStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.black_100),
                        fieldBorderColor: AppColors.blue_10,
                        fieldBorderRadius: 8,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter your Phone Number'.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.to(UserForgetPasswordScreen(
                      //         inAppForget: false));
                      //   },
                      //   child: const Align(
                      //     alignment: Alignment.topLeft,
                      //     child: CustomText(
                      //       text: AppStrings.forgetPassword,
                      //       fontWeight: FontWeight.w500,
                      //       color: AppColors.blue_100,
                      //       top: 16,
                      //       bottom: 24,
                      //     ),
                      //   ),
                      // ),
                      controller.isLoading
                          ? const CustomElevatedLoadingButton()
                          : CustomButton(
                              buttonWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                if (loginFormKey.currentState!.validate()) {
                                  // controller.loginUser(
                                  //   controller.usernameController.text
                                  //       .toString(),
                                  //   controller.passwordController.text
                                  //       .toString(),
                                  //   userType,
                                  // );

                                  controller.loginWithPhoneGenerateOTP();
                                }
                              },
                              titleText: AppStrings.signIn,
                              titleColor: AppColors.white,
                              buttonBgColor: AppColors.blue_100,
                              titleSize: 18,
                              titleWeight: FontWeight.w600,
                            ),
                      // const Align(
                      //   alignment: Alignment.center,
                      //   child: CustomText(
                      //     text: AppStrings.orContinueWith,
                      //     fontWeight: FontWeight.w500,
                      //     color: AppColors.black_80,
                      //     top: 32,
                      //     bottom: 32,
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         _authController
                      //             .signInWithGoogle(userType);
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.all(10),
                      //         decoration: const BoxDecoration(
                      //             color: Colors.white,
                      //             shape: BoxShape.circle),
                      //         child: const CustomImage(
                      //           imageSrc: AppIcons.google,
                      //           size: 28,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 24.w,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         _authController
                      //             .appleInWithGoogle(userType);
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.all(10),
                      //         decoration: const BoxDecoration(
                      //             color: Colors.white,
                      //             shape: BoxShape.circle),
                      //         child: const CustomImage(
                      //           imageSrc: AppIcons.apple,
                      //           size: 28,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 64),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: AppStrings.didNotHaveAnAccount,
                            color: AppColors.black_100,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.userSignUp,
                                  arguments: userType);
                            },
                            child: const CustomText(
                              text: AppStrings.signUp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blue_100,
                              left: 4,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
          ));
        }));
  }
}
