import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';
import 'package:find_worker/view/screens/user/user_auth/user_forget_password/user_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
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

  final String userType =Get.arguments;

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
        child: GetBuilder<AuthenticationController>(
          builder: (controller) {
         return Scaffold(
          body:  Container(
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF3F3F3),Color(0xFFCCE0FA),],
              ),
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                return  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 44,left: 20,right: 20,bottom: 24),
                    child: Form(
                      key: loginFormKey,
                      child: Column(
                        children: [
                          const CustomText(
                            text: AppStrings.welcomeToFindWorker,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            bottom: 66,
                          ),
                          const CustomText(
                            text: AppStrings.logo,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue_100,
                            bottom: 66,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: AppStrings.email,
                                fontWeight: FontWeight.w500,
                                bottom: 8,
                              ),
                              CustomTextField(
                                textEditingController: controller.usernameController,
                                textAlign: TextAlign.start,
                                hintText: AppStrings.enterYourEmail,
                                hintStyle: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_40),
                                inputTextStyle: GoogleFonts.poppins(
                                    color: AppColors.black_100),
                                fieldBorderColor: AppColors.blue_10,
                                fieldBorderRadius: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email".tr;
                                  } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(controller.usernameController.text)) {
                                    return "Please enter your valid email".tr;
                                  } else {
                                    return null;
                                  }
                                },

                              ),
                              const CustomText(
                                text: AppStrings.password,
                                fontWeight: FontWeight.w500,
                                top: 16,
                                bottom: 8,
                              ),
                              CustomTextField(
                                textEditingController: controller.passwordController,
                                isPassword: true,
                                textAlign: TextAlign.start,
                                hintText: AppStrings.enterYourPassword,
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
                                    return 'Enter your Password'.tr;
                                  } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                      .hasMatch(controller.passwordController.text)) {
                                    return "Please use uppercase, lowercase, special character, and number".tr;
                                  } else if (value.length < 8) {
                                    return "Please use 8 character long password".tr;
                                  }
                                  return null;
                                },
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(UserForgetPasswordScreen(inAppForget:false));
                                },
                                child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: CustomText(
                                    text: AppStrings.forgetPassword,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blue_100,
                                    top: 16,
                                    bottom: 24,
                                  ),
                                ),
                              ),
                              controller.isLoading? const CustomElevatedLoadingButton() :CustomButton(
                                buttonWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  if(loginFormKey.currentState!.validate()){
                                    controller.loginUser(
                                        controller.usernameController.text.toString(),
                                        controller.passwordController.text.toString(),
                                        userType,
                                    );
                                  }
                                },
                                titleText: AppStrings.signIn,
                                titleColor: AppColors.white,
                                buttonBgColor: AppColors.blue_100,
                                titleSize: 18,
                                titleWeight: FontWeight.w600,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: CustomText(
                                  text: AppStrings.orContinueWith,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_80,
                                  top: 32,
                                  bottom: 32,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _authController.signInWithGoogle(userType);
                                    },
                                    child: Container(
                                      padding:const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ),
                                      child: const CustomImage(
                                        imageSrc: AppIcons.google,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width:24.w ,),
                                  GestureDetector(
                                    onTap: (){
                                      _authController.appleInWithGoogle(userType); 
                                    },
                                    child: Container(
                                      padding:const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ),
                                      child: const CustomImage(
                                        imageSrc: AppIcons.apple,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 64),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    text: AppStrings.didNotHaveAnAccount,
                                    color: AppColors.black_100,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.toNamed(AppRoute.userSignUp,arguments:userType);
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
                    )
                );
              },
            ),
          )
    );
          }
        ));
  }
}
