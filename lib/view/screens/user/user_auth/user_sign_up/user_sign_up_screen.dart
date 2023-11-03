import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  List<String> genderList = ["Male", "Female", "Others"];
  int selectedGender = 0;
  bool isClicked = false;
  final registerFormKey = GlobalKey<FormState>();
  void changeGender(int index) {
    selectedGender = index;
    setState(() {});
  }

  @override
  void initState() {
    Get.put(AuthenticationController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(builder: (controller) {
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
                        padding:
                        const EdgeInsets.only(top: 44, left: 20,right: 20,bottom: 24),
                        child: Form(
                          key: controller.registerFormKey,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: const CustomImage(
                                    imageSrc: AppIcons.chevronLeft,
                                    size: 18,
                                  ),
                                ),
                                const CustomText(
                                  text: AppStrings.signUp,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox()
                              ],
                            ),
                            const SizedBox(
                              height: 34,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    text: AppStrings.fullName,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Name Not Be Empty".tr;
                                      } else if (value.length > 30) {
                                        return "Name is to long".tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    textEditingController: controller.nameController,
                                    textAlign: TextAlign.start,
                                    hintText: AppStrings.enterYourFullName,
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
                                  const CustomText(
                                    text: AppStrings.dateOfBirth,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8,
                                    top: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.pickedDate(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                                  )
                                              ),
                                              child: controller.year.isEmpty ? Text(
                                                "YYYY".tr,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                    color: const Color(0xff818181),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ) : Text(
                                                controller.year,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(
                                                    color: AppColors.black_100,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            )
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                                  )
                                              ),
                                              child: controller.month.isEmpty ? Text(
                                                "MM".tr,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                    color: const Color(0xff818181),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ) : Text(
                                                controller.month.padLeft(2, "0"),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(
                                                    color: AppColors.black_100,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            )
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.black_100
                                                  )
                                              ),
                                              child: controller.day.isEmpty ? Text(
                                                "DD".tr,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.raleway(
                                                    color: const Color(0xff818181),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ) : Text(
                                                controller.day.padLeft(2, "0"),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(
                                                    color: AppColors.black_100,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  const CustomText(
                                    text: AppStrings.gender,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8,
                                    top: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        genderList.length,
                                            (index) => GestureDetector(
                                          onTap: () => changeGender(index),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                padding:
                                                const EdgeInsetsDirectional
                                                    .all(0.5),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                        color:
                                                        AppColors.blue_100),
                                                    shape: BoxShape.circle),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: index ==
                                                          selectedGender
                                                          ? AppColors.blue_100
                                                          : Colors.transparent,
                                                      shape: BoxShape.circle),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                genderList[index],
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.black_100,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                  const CustomText(
                                    text: AppStrings.email,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    textEditingController: controller.emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your email".tr;
                                      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(controller.emailController.text)) {
                                        return "Please enter your valid email".tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    textAlign: TextAlign.start,
                                    hintText: AppStrings.enterYourEmail,
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black_40),
                                    inputTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_100),
                                    fieldBorderColor: AppColors.blue_10,
                                    fieldBorderRadius: 8,
                                  ),
                                  const CustomText(
                                    text: AppStrings.phoneNumber,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                            height: 60,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: AppColors.blue_10)),
                                            child: IntlPhoneField(
                                              initialCountryCode: 'MX',
                                              disableLengthCheck: true,
                                              showDropdownIcon: false,
                                              showCountryFlag: true,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  )),
                                              onChanged: (phone) {
                                                print(phone.completeNumber);
                                              },
                                            )),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 2,
                                        child: CustomTextField(
                                          textEditingController: controller.phoneController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value!.length > 10) {
                                              return "Phone number not less than 10 digits".tr;
                                            } else if (value.length < 6) {
                                              return "Phone number not more then 14 digits".tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                          textAlign: TextAlign.start,
                                          hintText: "Phone Number".tr,
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black_40),
                                          inputTextStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: AppColors.black_100),
                                          fieldBorderColor: AppColors.blue_10,
                                          fieldBorderRadius: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const CustomText(
                                    text: AppStrings.address,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    textEditingController: controller.addressController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Address Not Be Empty".tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    textAlign: TextAlign.start,
                                    hintText: 'Enter your address',
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black_40),
                                    inputTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_100),
                                    fieldBorderColor: AppColors.blue_10,
                                    fieldBorderRadius: 8,
                                  ),
                                  const CustomText(
                                    text: AppStrings.password,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    textEditingController: controller.passController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password Not Be Empty".tr;
                                      } else if (controller.passController.text !=
                                          controller.confirmPasswordController.text) {
                                        return "Password doesn't match".tr;
                                      }
                                      return null;
                                    },
                                    isPassword: true,
                                    textAlign: TextAlign.start,
                                    hintText: 'Enter 8 digit password',
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black_40),
                                    inputTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_100),
                                    fieldBorderColor: AppColors.blue_10,
                                    fieldBorderRadius: 8,
                                  ),
                                  const CustomText(
                                    text: AppStrings.confirmPassword,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    textInputAction: TextInputAction.done,
                                    textEditingController: controller.confirmPasswordController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter your Password'.tr;
                                      } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(controller.confirmPasswordController.text)) {
                                        return "Please use uppercase, lowercase, special character, and number".tr;
                                      } else if (value.length < 8) {
                                        return "Please use 8 character long password".tr;
                                      }
                                      return null;
                                    },
                                    isPassword: true,
                                    textAlign: TextAlign.start,
                                    hintText: AppStrings.enterYourPassword,
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black_40),
                                    inputTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_100),
                                    fieldBorderColor: AppColors.blue_10,
                                    fieldBorderRadius: 8,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  controller.isLoading ? const CustomElevatedLoadingButton(): CustomButton(
                                    buttonWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      controller.registerUser();
                                    },
                                    titleText: AppStrings.signUp,
                                    titleColor: AppColors.white,
                                    buttonBgColor: AppColors.blue_100,
                                    titleSize: 18,
                                    titleWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 24,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomText(
                                        text: AppStrings.alreadyHaveAnAccount,
                                        color: AppColors.black_100,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoute.userSignIn);
                                        },
                                        child: const CustomText(
                                          text: AppStrings.signIn,
                                          color: AppColors.blue_100,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          left: 4,
                                        ),
                                      ),
                                    ],
                                  )
                                ])
                          ]),
                        ));
                  }),
            ),
          ));
    },);
  }
}
