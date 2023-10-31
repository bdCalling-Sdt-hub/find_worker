import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SpResetPasswordScreen extends StatefulWidget {
  const SpResetPasswordScreen({super.key});

  @override
  State<SpResetPasswordScreen> createState() => _SpResetPasswordScreenState();
}

class _SpResetPasswordScreenState extends State<SpResetPasswordScreen> {
  /* @override
  void initState() {
    DeviceUtils.allScreenUtils();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.screenUtils();
    super.dispose();
  }*/
  final _formKey = GlobalKey<FormState>();
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3F3F3),Color(0xFFCCE0FA),],
            ),
          ),
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return  SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.black_100,),
                      ),
                      Text(
                        'Reset Password'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color:  AppColors.black_100,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox()
                    ],),
                  const SizedBox(height: 44,),
                  const Center(
                    child: CustomImage(
                        size: 120,
                        imageType: ImageType.png,
                        imageSrc: AppImages.authenticationOutline
                    ),
                  ),
                  const SizedBox(height: 44,),
                   Center(
                    child: CustomText(
                      fontSize: 14,
                      fontWeight:FontWeight.w500,
                      color: AppColors.black_100,
                      text: 'Password must have 8-10 characters.'.tr,
                    ),
                  ),
                  const SizedBox(height: 44,),
                   CustomText(
                    text: 'Password'.tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_100,
                  ),
                  const SizedBox(height:8),
                  CustomTextField(
                    isPassword: true,
                    isPrefixIcon: false,
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
                    fieldBorderColor: AppColors.black_10,
                    fieldBorderRadius: 8,
                  ),
                  const SizedBox(height: 24,),
                   CustomText(
                    text: "Confirm Password".tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_100,
                  ),
                  const SizedBox(height:8),
                  CustomTextField(
                    isPassword: true,
                    isPrefixIcon: false,
                    textAlign: TextAlign.start,
                    hintText: "Confirm your password".tr,
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_40),
                    inputTextStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black_100),
                    fieldBorderColor: AppColors.black_10,
                    fieldBorderRadius: 8,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 150),
                      height: 56 ,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff0668E3)
                      ),
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(AppRoute.spSignInScreen);
                        },
                        child:  Center(
                            child: CustomText(
                              text: 'Reset Password'.tr,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                      )
                  )
                ],
              ),
            );
          },),
        ),

      ),
    );
  }
}