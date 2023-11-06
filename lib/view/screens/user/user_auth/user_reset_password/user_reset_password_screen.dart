import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class UserResetPasswordScreen extends StatefulWidget {
  const UserResetPasswordScreen({super.key});

  @override
  State<UserResetPasswordScreen> createState() => _UserResetPasswordScreenState();
}

class _UserResetPasswordScreenState extends State<UserResetPasswordScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  String email = "";

  @override
  void initState() {

    email = Get.arguments;
    super.initState();
  }

  resetPassword(String email, String newPassword) async {
    setState(() {
      isLoading = true;
    });
    //pass the password here

    try{
      Fluttertoast.showToast(
          msg: "Password reset successfully",
          backgroundColor: AppColors.blue_100,
          textColor: AppColors.white,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      Get.offAndToNamed(AppRoute.userSignIn);
    } catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: AppColors.blue_100,
          textColor: AppColors.white,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
    }

    setState(() {
      isLoading = false;
    });
  }

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
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
                child: SingleChildScrollView(
                  child: Form(
                    key:_formKey,
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
                              AppStrings.resetPassword,
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
                         const Center(
                          child: CustomText(
                            fontSize: 14,
                            fontWeight:FontWeight.w500,
                            color: AppColors.black_100,
                            text: AppStrings.passwordMustHaveCharacters,
                          ),
                        ),
                        const SizedBox(height: 44,),
                        const CustomText(
                          text: AppStrings.password,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_100,
                        ),
                        const SizedBox(height:8),
                        CustomTextField(
                          validator: (value){
                            if(value!.isEmpty || value.length < 8) {
                              return "Please, use more than 6 characters long password";
                            }
                            return null;
                          },
                          textEditingController: newPasswordController ,
                          isPassword: true,
                          isPrefixIcon: false,
                          textAlign: TextAlign.start,
                          hintText: 'Enter your password',
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
                        const CustomText(
                          text: AppStrings.confirmPassword,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_100,
                        ),
                        const SizedBox(height:8),
                        CustomTextField(
                          validator: (value){
                            if(value!.isEmpty || value.length < 8) {
                              return "Please, use more than 6 characters long password";
                            }
                            else if(newPasswordController.text.toString() != confirmPasswordController.text.toString()){
                              return "Password does not match";
                            }
                            return null;
                          },
                          textEditingController: confirmPasswordController,
                          isPassword: true,
                          isPrefixIcon: false,
                          textAlign: TextAlign.start,
                          hintText: 'Confirm your password',
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
                        GestureDetector(
                          onTap: (){
                            if(_formKey.currentState!.validate()){
                              resetPassword(email, newPasswordController.text.toString());
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 186),
                              height: 56 ,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xff0668E3)
                              ),
                              child: const Center(
                                  child: CustomText(
                                    text: AppStrings.verify,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ))
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },),
          ),

      ),
    );
  }
}