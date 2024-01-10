import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';
import 'package:wrcontacts/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserOtpScreen extends StatefulWidget {
  const UserOtpScreen({super.key});

  @override
  State<UserOtpScreen> createState() => _UserOtpScreenState();
}

class _UserOtpScreenState extends State<UserOtpScreen> {
  // late String email;
  // late EmailOTP emailOTP;

  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  String userType = "";
  bool isSignIn = false;

  @override
  void initState() {
    userType = Get.arguments[0];
    isSignIn = Get.arguments[1];
    super.initState();
  }

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
              colors: [
                Color(0xFFF3F3F3),
                Color(0xFFCCE0FA),
              ],
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
                    const SizedBox(
                      height: 24,
                    ),
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
                          AppStrings.oTP,
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
                      height: 44,
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
                    const Center(
                      child: CustomText(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_100,
                        text: AppStrings.pleaseEnterTheOTPCode,
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    Flexible(
                      flex: 0,
                      child: PinCodeTextField(
                        cursorColor: AppColors.black_10,
                        controller: otpController,
                        appContext: (context),
                        validator: (value) {
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
                        animationDuration: Duration(milliseconds: 100),
                        keyboardType: TextInputType.number,
                        beforeTextPaste: (text) {
                          return true;
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: AppStrings.didNotGetTheCode,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_100,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.to(() => resendOtpToEmail());
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
                    isLoading
                        ? const CustomElevatedLoadingButton()
                        : GetBuilder<AuthenticationController>(
                            builder: (controller) {
                            return GestureDetector(
                              onTap: () {
                                // verifyEmailOTP();

                                print(
                                    "OTP++++++++++++++++++++${otpController.text}");

                                controller.varifyPhoneOTP(
                                    smsCode: otpController.text,
                                    isSignIn: isSignIn,
                                    userType: userType);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(top: 252),
                                  height: 56,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xff0668E3)),
                                  child: const Center(
                                      child: CustomText(
                                    text: AppStrings.verify,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ))),
                            );
                          })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Future<void> verifyEmailOTP() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   if (emailOTP.verifyOTP(otp: otpController.text.toString()) == true) {
  //     Fluttertoast.showToast(
  //         msg: "OTP is verified",
  //         backgroundColor: AppColors.blue_100,
  //         textColor: AppColors.black_100,
  //         fontSize: 14,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM);

  //     setState(() {
  //       isLoading = false;
  //     });

  //     Get.toNamed(AppRoute.userResetPasswordScreen, arguments: email);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Invalid OTP",
  //         backgroundColor: AppColors.blue_100,
  //         textColor: AppColors.black_100,
  //         fontSize: 14,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM);

  //     setState(() {
  //       isLoading = false;
  //     });
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future<void> resendOtpToEmail() async {
  //   emailOTP.setConfig(
  //       appEmail: "mohammadjubayed.islam97@gmail.com",
  //       appName: "#Jubayed11",
  //       userEmail: email,
  //       otpLength: 6,
  //       otpType: OTPType.digitsOnly);

  //   if (await emailOTP.sendOTP() == true) {
  //     Fluttertoast.showToast(
  //         msg: "OTP has been sent",
  //         backgroundColor: AppColors.blue_100,
  //         textColor: AppColors.black_100,
  //         fontSize: 14,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Oops! OTP send failed",
  //         backgroundColor: AppColors.blue_100,
  //         textColor: AppColors.black_100,
  //         fontSize: 14,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM);
  //   }
  // }
}
