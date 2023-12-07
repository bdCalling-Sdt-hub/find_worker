import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class UserEmailOtpScreen extends StatefulWidget {
  const UserEmailOtpScreen({super.key});

  @override
  State<UserEmailOtpScreen> createState() => _UserEmailOtpScreenState();
}

class _UserEmailOtpScreenState extends State<UserEmailOtpScreen> {
/*  @override
  void initState() {
    DeviceUtils.allScreenUtils();
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.allScreenUtils();
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
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding:const EdgeInsets.only(left: 20,right: 20,top: 44,bottom: 24),
              child: Column(
                children: [
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
                        AppStrings.verifyEmail,
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
                        imageSrc: AppImages.newMessageOutline
                    ),
                  ),
                  const SizedBox(height: 44,),
                  const Center(
                    child: CustomText(
                      maxLines: 2,
                      fontSize: 14,
                      fontWeight:FontWeight.w500,
                      color: AppColors.black_100,
                      text: AppStrings.weSentaVerification,
                    ),
                  ),
                  const SizedBox(height: 44,),
                  Flexible(
                    flex: 0,
                    child: PinCodeTextField(
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
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: AppStrings.didNotGetTheCode ,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_100,
                      ),
                      GestureDetector(
                        onTap: () {
                          /*Get.to(()=> const OtpScreen());*/
                        },
                        child: const CustomText(
                          text: AppStrings.resend,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue_100,

                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 216),
                      height: 56 ,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff0668E3)
                      ),
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(AppRoute.userSignIn);
                        },
                        child: const Center(
                            child: CustomText(
                              text: AppStrings.verify,
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