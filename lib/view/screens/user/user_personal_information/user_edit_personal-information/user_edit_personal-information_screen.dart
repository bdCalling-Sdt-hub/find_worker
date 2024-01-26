import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/model/user_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_profile/Controller/profile_controller.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_back.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:wrcontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../helper/SystemChromeHelper/system_chrome.dart';
import '../../../../widgets/custom_button.dart';
import '../../user_auth/user_sign_up/more_sign_up_screen.dart';

class UserEditPersonalInformation extends StatefulWidget {
  const UserEditPersonalInformation({super.key});

  @override
  State<UserEditPersonalInformation> createState() =>
      _UserEditPersonalInformationState();
}

class _UserEditPersonalInformationState
    extends State<UserEditPersonalInformation> {
  final _profileController = Get.put(UserProfileController());
  @override
  void initState() {
    SystemChromeHelper.enableSystemChrome();
    _profileController.setData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChromeHelper.blueColorSystemChrome();
    super.dispose();
  }

  bool isClicked = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemChromeHelper.enableSystemChrome(),
        title: Text(AppStrings.editPersonalInformation.tr,),leading: CustomBack(),),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 44, left: 20, right: 20, bottom: 24),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Get.back();
                //       },
                //       child: const Icon(
                //         Icons.arrow_back_ios_new_outlined,
                //         size: 16,
                //         color: AppColors.blue_100,
                //       ),
                //     ),
                //      CustomText(
                //       text: AppStrings.editPersonalInformation.tr,
                //       color: AppColors.blue_100,
                //       fontSize: 18,
                //       fontWeight: FontWeight.w500,
                //     ),
                //     const SizedBox()
                //   ],
                // ),
                const SizedBox(
                  height: 34,
                ),
                Center(
                  child: SizedBox(
                    height: 130,
                    width: 130,
                    child: Stack(
                      children: [
                        Center(
                          child: Obx(
                            () => Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.6),
                                  image: _profileController
                                          .imagePath.isNotEmpty
                                      ? DecorationImage(
                                          image: FileImage(File(
                                              _profileController
                                                  .imagePath.value)),fit: BoxFit.fill)
                                      : _profileController.userData.value
                                                  .imageSrc !=
                                              null
                                          ? _profileController.userData
                                                      .value.imageSrc !=
                                                  ""
                                              ? DecorationImage(
                                      fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      _profileController
                                                          .userData
                                                          .value
                                                          .imageSrc!))
                                              : const DecorationImage(
                                    fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      AppIcons.unSplashProfileImage),
                                                )
                                          : const DecorationImage(
                                    fit: BoxFit.fill,
                                              image: AssetImage(
                                                  AppIcons.unSplashProfileImage),
                                            )),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              _profileController.picImage(
                                  ImageSource.gallery);
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //           title: Text(
                              //             "Select Source",
                              //             style: TextStyle(
                              //                 fontSize: 18.sp,
                              //                 fontWeight: FontWeight.w500),
                              //           ),
                              //           content: Column(
                              //             mainAxisSize: MainAxisSize.min,
                              //             children: [
                              //               ListTile(
                              //                 onTap: () {
                              //                   _profileController.picImage(
                              //                       ImageSource.camera);
                              //                   Get.back();
                              //                 },
                              //                 leading: const Icon(
                              //                     Icons.photo_camera),
                              //                 title: const Text(
                              //                   "Take Photo",
                              //                 ),
                              //               ),
                              //               ListTile(
                              //                 onTap: () {
                              //                   _profileController.picImage(
                              //                       ImageSource.gallery);
                              //                   Get.back();
                              //                 },
                              //                 leading: const Icon(Icons.photo),
                              //                 title: const Text(
                              //                   "Choose from Gallery",
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.blue_100,
                                  shape: BoxShape.circle,
                                  // image: DecorationImage(image: AssetImage('assets/images/profile_icon.png')),
                                ),
                                child: const CustomImage(
                                  imageSrc: AppIcons.camera,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           CustomText(
                            text: AppStrings.fullName.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            bottom: 8,
                          ),
                          CustomTextField(
                            textAlign: TextAlign.start,
                            hintText: 'Enter your full name'.tr,
                            textEditingController:
                                _profileController.nameCtrl,
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
                           CustomText(
                            text: AppStrings.dateOfBirth.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            bottom: 8,
                            top: 16,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsetsDirectional.symmetric(
                                        horizontal: 15, vertical: 3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xffE2E2E2)
                                        // color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                        )),
                                child: TextFormField(
                                  controller: _profileController.dobDayCtrl,
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Empty".tr;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    hintText: "DD",
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9-]")),
                                    LengthLimitingTextInputFormatter(2),
                                    DayFormatter(),
                                  ],
                                ),
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsetsDirectional.symmetric(
                                        horizontal: 15, vertical: 3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xffE2E2E2)
                                        //    color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                        )),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller:
                                      _profileController.dobMonthCtrl,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Empty".tr;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "MM",
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9-]")),
                                    LengthLimitingTextInputFormatter(2),
                                    MonthFormatter(),
                                  ],
                                ),
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsetsDirectional.symmetric(
                                        horizontal: 15, vertical: 3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xffE2E2E2)
                                        //   color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                        )),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.datetime,
                                  controller:
                                      _profileController.dobYearCtrl,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Empty".tr;
                                    } else if (value.length < 4) {
                                      return "Valid Year";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "YYYY",
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9-]")),
                                    LengthLimitingTextInputFormatter(4),
                                    YearFormatter(),
                                  ],
                                ),
                              )),
                            ],
                          ),
                           CustomText(
                            text: AppStrings.gender.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            bottom: 8,
                            top: 16,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                _profileController.genderList.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        _profileController
                                            .selectGender.value = index;
                                      },
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
                                            child: Obx(
                                              () => Container(
                                                decoration: BoxDecoration(
                                                    color: index ==
                                                            _profileController
                                                                .selectGender
                                                                .value
                                                        ? AppColors.blue_100
                                                        : Colors
                                                            .transparent,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _profileController
                                                .genderList[index].tr,
                                            style: GoogleFonts.poppins(
                                                color: AppColors.black_100,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    )),
                          ),

                           CustomText(
                            text: AppStrings.email.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            top: 16,
                            bottom: 8,
                          ),
                          CustomTextField(
                            textEditingController:
                            _profileController.emailCtrl,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email".tr;
                              } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(
                                  _profileController.emailCtrl.text)) {
                                return "Please enter your valid email".tr;
                              } else {
                                return null;
                              }
                            },
                            textAlign: TextAlign.start,
                            hintText: AppStrings.enterYourEmail.tr,
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

                          /// <------------------  Phone Number ------------------->
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Flexible(
                          //       flex: 1,
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 4),
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //               color: const Color(0xFFE2E2E2)),
                          //           borderRadius: BorderRadius.circular(8),
                          //           color: Colors.white,
                          //         ),
                          //         child: CountryCodePicker(
                          //           initialSelection:
                          //               _profileController.phoneCode.value,
                          //           onChanged: (value) {
                          //           _profileController.phoneCode.value=value.dialCode!;
                          //           },
                          //           showCountryOnly: false,
                          //           showOnlyCountryWhenClosed: false,
                          //           alignLeft: false,
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 8),
                          //     Expanded(
                          //       flex: 2,
                          //       child: CustomTextField(
                          //         textEditingController:
                          //             _profileController.phoneCtrl,
                          //         keyboardType: TextInputType.number,
                          //         maxLength: 10,
                          //         textInputAction: TextInputAction.next,
                          //         validator: (value) {
                          //           if (value!.length > 10) {
                          //             return "Phone number not less than 10 digits"
                          //                 .tr;
                          //           } else if (value.length < 6) {
                          //             return "Phone number not more then 14 digits"
                          //                 .tr;
                          //           } else {
                          //             return null;
                          //           }
                          //         },
                          //         textAlign: TextAlign.start,
                          //         hintText: "Phone Number".tr,
                          //         hintStyle: GoogleFonts.poppins(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w500,
                          //             color: AppColors.black_40),
                          //         inputTextStyle: GoogleFonts.poppins(
                          //             fontWeight: FontWeight.w400,
                          //             fontSize: 14,
                          //             color: AppColors.black_100),
                          //         fieldBorderColor: AppColors.blue_10,
                          //         fieldBorderRadius: 8,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                           CustomText(
                            text: AppStrings.address.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            top: 16,
                            bottom: 8,
                          ),
                          CustomTextField(
                            maxLines: 5,
                            textEditingController:
                                _profileController.addressCtrl,
                            textAlign: TextAlign.start,
                            hintText: 'Enter your address'.tr,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
                          Obx(()=>
                             CustomButton(
                              text: AppStrings.update.tr,
                              loading: _profileController.loading.value,
                              onTap: (){
                                _profileController.updateProfile();

                              },
                            ),
                          ),
                        ]))
              ],
            ));
      }),
    );
  }
}
