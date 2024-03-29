import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_images.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:wocontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpForgetPasswordScreen extends StatefulWidget {
  const SpForgetPasswordScreen({super.key});

  @override
  State<SpForgetPasswordScreen> createState() => _SpForgetPasswordScreenState();
}

class _SpForgetPasswordScreenState extends State<SpForgetPasswordScreen> {
/*  @override
  void initState() {
    DeviceUtils.allScreenUtils();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.screenUtils();
    super.dispose();
  }*/

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
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 16,
                            color: AppColors.black_100,
                          ),
                        ),
                        Text(
                          AppStrings.forgetPassword,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: AppColors.black_100,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 62,
                    ),
                    const Center(
                      child: CustomImage(
                          size: 120,
                          imageType: ImageType.png,
                          imageSrc: AppImages.passwordOutline),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    const CustomText(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_100,
                      text: AppStrings.enterEmailAddressToResetPassword,
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    const CustomText(
                      text: AppStrings.email,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_100,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textAlign: TextAlign.start,
                      hintText: 'Enter your email',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_40),
                      inputTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.black_100),
                      fieldBorderColor: AppColors.blue_10,
                      fieldBorderRadius: 8,
                    ),

                    Container(
                        margin: const EdgeInsets.only(top: 252),
                        height: 56 ,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff0668E3)
                        ),
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(AppRoute.spOtpScreen);
                          },
                          child: const Center(
                              child: CustomText(
                                text: AppStrings.getOTP,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                        )
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}