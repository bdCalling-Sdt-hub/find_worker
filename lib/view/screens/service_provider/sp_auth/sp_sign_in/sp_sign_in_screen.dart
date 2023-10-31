import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpSignInScreen extends StatefulWidget {
  const SpSignInScreen({super.key});

  @override
  State<SpSignInScreen> createState() => _SpSignInScreenState();
}

class _SpSignInScreenState extends State<SpSignInScreen> {
  bool isClicked=false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                return  SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 44,horizontal: 20),
                  child: Column(
                    children: [
                       CustomText(
                        text: 'Welcome to Find Worker!'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        bottom: 66,
                      ),
                       CustomText(
                        text: 'Logo'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue_100,
                        bottom: 66,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             CustomText(
                              text: 'Email'.tr,
                              fontWeight: FontWeight.w500,
                              bottom: 8,
                            ),
                            CustomTextField(
                              textAlign: TextAlign.start,
                              hintText: 'Enter your email'.tr,
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_40),
                              inputTextStyle: GoogleFonts.poppins(
                                  color: AppColors.black_100),
                              fieldBorderColor: AppColors.blue_10,
                              fieldBorderRadius: 8,
                            ),
                             CustomText(
                              text: 'Password'.tr,
                              fontWeight: FontWeight.w500,
                              top: 16,
                              bottom: 8,
                            ),
                            CustomTextField(
                              isPassword: true,
                              textAlign: TextAlign.start,
                              hintText: 'Enter your password'.tr,
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
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.spForgetPasswordScreen);
                              },
                              child:  Align(
                                alignment: Alignment.topLeft,
                                child: CustomText(
                                  text: 'Forget Password'.tr,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blue_100,
                                  top: 16,
                                  bottom: 24,
                                ),
                              ),
                            ),
                            CustomButton(
                              buttonWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                 /*Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> SpBottomNavBarScreen(currentIndex: 0)), (route) => false);*/
                                Get.to(SpBottomNavBarScreen(currentIndex: 0));
                              },
                              titleText: 'Sign In'.tr,
                              titleColor: AppColors.white,
                              buttonBgColor: AppColors.blue_100,
                              titleSize: 18,
                              titleWeight: FontWeight.w600,
                            ),
                             Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                text: 'Or continue with'.tr,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_80,
                                top: 32,
                                bottom: 32,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
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
                                Container(
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
                              ],
                            ),
                            const SizedBox(height: 64),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 CustomText(
                                  text: 'Didn’t have an account?'.tr,
                                  color: AppColors.black_100,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.spSignUpScreen);
                                  },
                                  child:  CustomText(
                                    text: 'Sign Up'.tr,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blue_100,
                                    left: 4,
                                    right: 4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
