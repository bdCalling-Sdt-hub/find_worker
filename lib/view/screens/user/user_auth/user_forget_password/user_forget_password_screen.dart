import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:wrcontacts/view/widgets/custom_button.dart';
import 'package:wrcontacts/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:wrcontacts/view/widgets/email_otp/email_otp.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:wrcontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/forget_pass_controller.dart';

class UserForgetPasswordScreen extends StatefulWidget {
  const UserForgetPasswordScreen({super.key,required this.inAppForget});

  final bool inAppForget;

  @override
  State<UserForgetPasswordScreen> createState() => _UserForgetPasswordScreenState();
}

class _UserForgetPasswordScreenState extends State<UserForgetPasswordScreen> {

  final TextEditingController emailController = TextEditingController();
  final _forgotPassController =Get.put(ForgetPassController());
  final _formKey = GlobalKey<FormState>();
  final emailRegExP = RegExp ("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");

  final emailOtp = EmailOTP();

  bool isLoading = false;

  Future<void> sendOtpToEmail() async{

    setState(() {
      isLoading = true;
    });

    emailOtp.setConfig(
        appEmail: "mohammadjubayed.islam97@gmail.com",
        appName: "Find Worker",
        userEmail: emailController.text.toString(),
        otpLength: 6,
        otpType: OTPType.digitsOnly
    );

    if(await emailOtp.sendOTP() == true){
      Fluttertoast.showToast(
          msg: "OTP has been sent",
          backgroundColor: AppColors.blue_100,
          textColor: AppColors.black_100,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      setState(() {
        isLoading = false;
      });
      Get.offAndToNamed(AppRoute.userOtpScreen, arguments: [emailController.text.toString(), emailOtp]);
    }
    else{
      Fluttertoast.showToast(
          msg: "Oops! OTP send failed",
          backgroundColor: AppColors.blue_100,
          textColor: AppColors.black_100,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }




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
            decoration:widget.inAppForget?const BoxDecoration(): const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF3F3F3),Color(0xFFCCE0FA),],
              ),
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20, vertical: 24),
                        child: Form(
                          key: _formKey,
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
                                    AppStrings.forgetPassword.tr,
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
                              widget.inAppForget?SizedBox(height: 40,):
                              const SizedBox(
                                height: 62,
                              ),
                               if(!widget.inAppForget)
                               const Center(
                                child: CustomImage(
                                    size: 120,
                                    imageType: ImageType.png,
                                    imageSrc: AppImages.passwordOutline),
                              ),
                              if(!widget.inAppForget)
                              const SizedBox(
                                height: 44,
                              ),
                                CustomText(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_100,
                                text: AppStrings.enterEmailAddressToResetPassword.tr,
                              ),
                              widget.inAppForget?const SizedBox(height: 20,):
                              const SizedBox(
                                height: 44,
                              ),
                               CustomText(
                                text: AppStrings.email.tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_100,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                textEditingController:_forgotPassController.textEditingController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.start,
                                hintText: 'Enter your email'.tr,
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
                                validator: (value) {
                                  if(value!.isEmpty || !value.contains("@") || !emailRegExP.hasMatch(value))
                                  {
                                    return "Please, enter your valid email".tr;
                                  }
                                  return null;
                                },
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(()=>
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomButton(
                            loading: _forgotPassController.loading.value,
                            text: AppStrings.submit.tr,
                            height: 56.h ,
                            width: MediaQuery.of(context).size.width,
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                _forgotPassController.resetPassword(_forgotPassController.textEditingController.text.trim(),widget.inAppForget);
                              }
                            },

                          ),
                        ),
                    ),
                    SizedBox(height:54.h,)
                  ],
                );
              },
            ),
          ),
         ),
    );
  }


}