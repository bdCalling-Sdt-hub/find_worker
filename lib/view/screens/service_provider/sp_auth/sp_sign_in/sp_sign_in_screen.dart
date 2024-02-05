import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:wocontacts/view/widgets/buttons/custom_button.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:wocontacts/view/widgets/text_field/custom_text_field.dart';
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
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: AppStrings.email,
                              fontWeight: FontWeight.w500,
                              bottom: 8,
                            ),
                            CustomTextField(
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
                            ),
                            const CustomText(
                              text: AppStrings.password,
                              fontWeight: FontWeight.w500,
                              top: 16,
                              bottom: 8,
                            ),
                            CustomTextField(
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
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.spForgetPasswordScreen);
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
                            CustomButton(
                              buttonWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> SpBottomNavBarScreen(currentIndex: 0)), (route) => false);
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
                                const CustomText(
                                  text: AppStrings.didNotHaveAnAccount,
                                  color: AppColors.black_100,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.spSignUpScreen);
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
