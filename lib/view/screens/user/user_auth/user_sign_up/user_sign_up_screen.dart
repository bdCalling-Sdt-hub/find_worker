import 'package:country_code_picker/country_code_picker.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';
import 'package:wrcontacts/view/widgets/buttons/custom_button.dart';
import 'package:wrcontacts/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:wrcontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final authController = Get.put(AuthenticationController());
  String userType = Get.arguments;
  final registerFormKey = GlobalKey<FormState>();
  void changeGender(int index) {
    authController.selectedGender = index;
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    authController.phoneCode="+971";
    authController.phoneController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authController.phoneCode="+971";
    authController.phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (controller) {
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
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          top: 44, left: 20, right: 20, bottom: 24),
                      child: Form(
                        key: controller.registerFormKey,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
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
                                  textEditingController:
                                      controller.nameController,
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

                                /// <----------------------- Date of Birth---------------->
                                CustomTextField(
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Date of Birth Not Be Empty".tr;
                                  //   }
                                  //   return null;
                                  // },
                                  readOnly: true,
                                  onTap: () {
                                    authController.selectDate(context);
                                  },
                                  suffixIcon: const Icon(
                                    Icons.date_range,
                                    color: Colors.grey,
                                  ),
                                  textEditingController:
                                      controller.dobController,
                                  textAlign: TextAlign.start,
                                  hintText: AppStrings.dateOfBirth,
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

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Expanded(
                                //         child:Container(
                                //           width: MediaQuery.of(context).size.width,
                                //           padding: const EdgeInsetsDirectional.symmetric(horizontal:15,vertical: 3),
                                //           alignment: Alignment.center,
                                //           decoration: BoxDecoration(
                                //               color: AppColors.white,
                                //               borderRadius: BorderRadius.circular(8),
                                //               border: Border.all(
                                //                 color: Color(0xffE2E2E2)
                                //                   // color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                //               )
                                //           ),
                                //           child: TextFormField(
                                //             controller:authController.dayController,
                                //             textAlign: TextAlign.center,
                                //             validator: (value){
                                //               if(value!.isEmpty){
                                //                 return "Empty";
                                //               }
                                //             },
                                //             keyboardType: TextInputType.datetime,
                                //             decoration: const InputDecoration(
                                //               hintText: "DD",
                                //               contentPadding: EdgeInsets.zero,
                                //               enabledBorder: OutlineInputBorder(
                                //                   borderSide: BorderSide.none
                                //               ),
                                //
                                //               focusedBorder: OutlineInputBorder(
                                //                   borderSide: BorderSide.none
                                //               ),
                                //             ),
                                //             inputFormatters: [
                                //               FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                                //               LengthLimitingTextInputFormatter(2),
                                //               DayFormatter(),
                                //             ],
                                //           ),
                                //         )
                                //     ),
                                //
                                //     const SizedBox(width: 12),
                                //     Expanded(
                                //         child:Container(
                                //           width: MediaQuery.of(context).size.width,
                                //           padding: const EdgeInsetsDirectional.symmetric(horizontal:15,vertical: 3),
                                //           alignment: Alignment.center,
                                //           decoration: BoxDecoration(
                                //               color: AppColors.white,
                                //               borderRadius: BorderRadius.circular(8),
                                //               border: Border.all(
                                //                   color: Color(0xffE2E2E2)
                                //               //    color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                //               )
                                //           ),
                                //           child: TextFormField(
                                //             textAlign: TextAlign.center,
                                //             controller:authController.monthController,
                                //              keyboardType: TextInputType.datetime,
                                //             validator: (value){
                                //               if(value!.isEmpty){
                                //                 return "Empty";
                                //               }
                                //               return null;
                                //             },
                                //             decoration: const InputDecoration(
                                //               hintText: "MM",
                                //               contentPadding: EdgeInsets.zero,
                                //               enabledBorder: OutlineInputBorder(
                                //                   borderSide: BorderSide.none
                                //               ),
                                //
                                //               focusedBorder: OutlineInputBorder(
                                //                   borderSide: BorderSide.none
                                //               ),
                                //             ),
                                //             inputFormatters: [
                                //               FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                                //               LengthLimitingTextInputFormatter(2),
                                //               MonthFormatter(),
                                //             ],
                                //           ),
                                //         )
                                //     ),
                                //     const SizedBox(width: 12),
                                //     Expanded(
                                //         child: Container(
                                //           width: MediaQuery.of(context).size.width,
                                //           padding: const EdgeInsetsDirectional.symmetric(horizontal:15,vertical: 3),
                                //           alignment: Alignment.center,
                                //           decoration: BoxDecoration(
                                //               color: AppColors.white,
                                //               borderRadius: BorderRadius.circular(8),
                                //               border: Border.all(
                                //                   color: Color(0xffE2E2E2)
                                //                //   color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                //               )
                                //           ),
                                //           child: TextFormField(
                                //             textAlign: TextAlign.center,
                                //              keyboardType: TextInputType.datetime,
                                //             controller:authController.yearController,
                                //             validator: (value){
                                //               if(value!.isEmpty){
                                //                 return "Empty";
                                //               }else if(value.length<4){
                                //                 return "Valid Year";
                                //               }
                                //             },
                                //             decoration: const InputDecoration(
                                //               hintText: "YYYY",
                                //               contentPadding: EdgeInsets.zero,
                                //               enabledBorder: OutlineInputBorder(
                                //                 borderSide: BorderSide.none
                                //               ),
                                //
                                //               focusedBorder: OutlineInputBorder(
                                //                 borderSide: BorderSide.none
                                //               ),
                                //             ),
                                //             inputFormatters: [
                                //               FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                                //               LengthLimitingTextInputFormatter(4),
                                //               YearFormatter(),
                                //             ],
                                //           ),
                                //         )
                                //     ),
                                //   ],
                                // ),
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
                                      authController.genderList.length,
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
                                                          color: AppColors
                                                              .blue_100),
                                                      shape: BoxShape.circle),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: index ==
                                                                authController
                                                                    .selectedGender
                                                            ? AppColors.blue_100
                                                            : Colors
                                                                .transparent,
                                                        shape: BoxShape.circle),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  authController
                                                      .genderList[index],
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                          AppColors.black_100,
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
                                  textEditingController:
                                      controller.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your email".tr;
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(
                                            controller.emailController.text)) {
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

                                /// <------------------  Phone Number ------------------->
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFE2E2E2)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: CountryCodePicker(
                                         initialSelection:authController.phoneCode,
                                          onChanged: (value) {
                                            authController.phoneCode =
                                                value.dialCode!;
                                            authController.update();
                                            print(authController.phoneCode);
                                          },
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextField(
                                        textEditingController:
                                            controller.phoneController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.length > 10) {
                                            return "Phone number not less than 10 digits"
                                                .tr;
                                          } else if (value.length < 6) {
                                            return "Phone number not more then 14 digits"
                                                .tr;
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
                                  bottom: 8,
                                ),
                                CustomTextField(
                                  textEditingController:
                                      controller.addressController,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Address Not Be Empty".tr;
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
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

                                // const CustomText(
                                //   text: AppStrings.password,
                                //   color: AppColors.black_100,
                                //   fontWeight: FontWeight.w500,
                                //   top: 16,
                                //   bottom: 8,
                                // ),
                                // CustomTextField(
                                //   textEditingController:
                                //       controller.passController,
                                //   validator: (value) {
                                //     if (value.isEmpty) {
                                //       return "Password Not Be Empty".tr;
                                //     }
                                //     return null;
                                //   },
                                //   isPassword: true,
                                //   textAlign: TextAlign.start,
                                //   hintText: 'Enter 8 digit password',
                                //   hintStyle: GoogleFonts.poppins(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w500,
                                //       color: AppColors.black_40),
                                //   inputTextStyle: GoogleFonts.poppins(
                                //       fontWeight: FontWeight.w400,
                                //       fontSize: 14,
                                //       color: AppColors.black_100),
                                //   fieldBorderColor: AppColors.blue_10,
                                //   fieldBorderRadius: 8,
                                // ),
                                // const CustomText(
                                //   text: AppStrings.confirmPassword,
                                //   color: AppColors.black_100,
                                //   fontWeight: FontWeight.w500,
                                //   top: 16,
                                //   bottom: 8,
                                // ),
                                // CustomTextField(
                                //   textInputAction: TextInputAction.done,
                                //   textEditingController:
                                //       controller.confirmPasswordController,
                                //   validator: (value) {
                                //     if (value.isEmpty) {
                                //       return 'Enter your Password'.tr;
                                //     } else if (!RegExp(
                                //             r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                //         .hasMatch(controller
                                //             .confirmPasswordController.text)) {
                                //       return "Please use uppercase, lowercase, special character, and number"
                                //           .tr;
                                //     } else if (value.length < 8) {
                                //       return "Please use 8 character long password"
                                //           .tr;
                                //     } else if (controller.passController.text !=
                                //         value) {
                                //       return "Password doesn't match".tr;
                                //     }
                                //     return null;
                                //   },
                                //   isPassword: true,
                                //   textAlign: TextAlign.start,
                                //   hintText: AppStrings.enterYourPassword,
                                //   hintStyle: GoogleFonts.poppins(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w500,
                                //       color: AppColors.black_40),
                                //   inputTextStyle: GoogleFonts.poppins(
                                //       fontWeight: FontWeight.w400,
                                //       fontSize: 14,
                                //       color: AppColors.black_100),
                                //   fieldBorderColor: AppColors.blue_10,
                                //   fieldBorderRadius: 8,
                                // ),
                                const SizedBox(
                                  height: 24,
                                ),
                                controller.isLoading
                                    ? const CustomElevatedLoadingButton()
                                    : CustomButton(
                                        buttonWidth:
                                            MediaQuery.of(context).size.width,
                                        onPressed: () {
                                          if (controller
                                              .registerFormKey.currentState!
                                              .validate()) {
                                            controller
                                                .loginWithPhoneGenerateOTP(
                                                    isSignIn: false,
                                                    userType: userType);
                                          }
                                        },
                                        titleText: AppStrings.signUp,
                                        titleColor: AppColors.white,
                                        buttonBgColor: AppColors.blue_100,
                                        titleSize: 18,
                                        titleWeight: FontWeight.w600,
                                      ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CustomText(
                                      text: AppStrings.alreadyHaveAnAccount,
                                      color: AppColors.black_100,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
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
      },
    );
  }
}

class YearFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;

    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 5 && pLen == 4) {
      // User has entered a complete 4-digit year, do not modify
      return currText;
    } else if (cLen == 1) {
      // Ensure the first character is within 1-2 (i.e., 19 or 20)
      int y1 = int.parse(cText);
      if (y1 < 1 || y1 > 2) {
        // Remove the first character
        cText = '';
      }
    } else if (cLen == 2) {
      // Ensure the first two characters are within 19 or 20
      int y1 = int.parse(cText.substring(0, 2));
      if (y1 < 19 || y1 > 20) {
        // Remove the second character
        cText = cText.substring(0, 1);
      }
    } else if (cLen > 4) {
      // User has entered more than 4 digits, truncate it
      cText = cText.substring(0, 4);
    }

    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: cText.length),
    );
  }
}

class DayFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class MonthFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    String cText = currText.text;
    int cLen = cText.length;

    if (cLen == 1) {
      // If the input has only one character, it can only be 0, 1, 2, or 3.
      if (int.tryParse(cText) == null || int.parse(cText) > 3) {
        // Invalid input, remove the character.
        return TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    } else if (cLen == 2) {
      // If the input has exactly 2 characters, validate the month.
      int? mm = int.tryParse(cText);
      if (mm == null || mm < 1 || mm > 12) {
        // Invalid month, keep only the first character.
        return TextEditingValue(
          text: cText.substring(0, 1),
          selection: TextSelection.collapsed(offset: 1),
        );
      }
    }

    // If the input is valid, allow it to continue.
    return currText;
  }
}
