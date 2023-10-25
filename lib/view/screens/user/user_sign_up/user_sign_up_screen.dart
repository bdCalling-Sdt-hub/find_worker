import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
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
  void changeGender(int index) {
    selectedGender = index;
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(children: [
                    const SizedBox(
                      height: 44,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImage(
                          imageSrc: AppIcons.chevronLeft,
                          size: 18,
                        ),
                        CustomText(
                          text: AppStrings.signUp,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: AppStrings.fullName,
                                color: AppColors.black_100,
                                fontWeight: FontWeight.w400,
                                bottom: 8,
                              ),
                              CustomTextField(
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
                                fontWeight: FontWeight.w400,
                                bottom: 8,
                                top: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      textAlign: TextAlign.center,
                                      hintText: AppStrings.dd,
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
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      textAlign: TextAlign.center,
                                      hintText: AppStrings.mm,
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
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      textAlign: TextAlign.center,
                                      hintText: AppStrings.yyyy,
                                      hintStyle: GoogleFonts.poppins(
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
                                  ),
                                ],
                              ),
                              const CustomText(
                                text: AppStrings.gender,
                                color: AppColors.black_100,
                                fontWeight: FontWeight.w400,
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
                                textAlign: TextAlign.start,
                                hintText: AppStrings.enterYourEmail,
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
                                text: AppStrings.phoneNumber,
                                color: AppColors.black_100,
                                top: 16,
                                bottom: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
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
                                          ))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: CustomTextField(
                                      textAlign: TextAlign.start,
                                      hintText: AppStrings.enterYourEmail,
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
                                  ),
                                ],
                              ),
                              const CustomText(
                                text: AppStrings.password,
                                color: AppColors.black_100,
                                fontWeight: FontWeight.w500,
                                top: 16,
                                bottom: 8,
                              ),
                              CustomTextField(
                                isPassword: true,
                                textAlign: TextAlign.start,
                                hintText: 'Enter 8 digit password',
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
                                text: AppStrings.confirmPassword,
                                color: AppColors.black_100,
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
                              const SizedBox(
                                height: 24,
                              ),
                              CustomButton(
                                buttonWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  Get.toNamed(AppRoute.userSignIn);
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
                            ]))
                  ]));
            }),
          ),
        ));
  }
}
