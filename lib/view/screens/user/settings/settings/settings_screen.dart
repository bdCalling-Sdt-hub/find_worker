
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/advanced_switch/advanced_switch.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../../helper/Language/language_component.dart';
import '../../../../../helper/Language/language_controller.dart';
import '../../../../../helper/SystemChromeHelper/system_chrome.dart';
import '../../../../widgets/account_delete_dialog.dart';
import '../../../../widgets/custom_back.dart';
import '../../../../widgets/custom_switch.dart';



class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // ...
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    SystemChromeHelper.enableSystemChrome();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    SystemChromeHelper.blueColorSystemChrome();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppStrings.settings.tr),
          leading: CustomBack(),
        ),
      // appBar:CustomAppBar(
      //     appBarContent: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         GestureDetector(
      //           onTap:(){
      //             Get.back();
      //           },
      //           child:  const Icon(
      //             Icons.arrow_back_ios_new_outlined,
      //             size: 18,
      //             color: AppColors.blue_100,
      //           ),
      //         ),
      //           CustomText(
      //           text: AppStrings.settings.tr,
      //           fontSize: 18,
      //           fontWeight: FontWeight.w500,
      //           color: AppColors.blue_100,
      //         ),
      //         const SizedBox()
      //       ],
      //     )),
      body:LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       CustomText(
                        text: AppStrings.language.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                      ),
                      CustomSwicth(onChanged: (bool value) {
                         if(!value){
                        localizationController.setLanguage(Locale(
                            LanguageComponent.languages[0].languageCode,
                            LanguageComponent
                                .languages[0].countryCode));
                        localizationController.setSelectIndex(0);

                      }else{
                        localizationController.setLanguage(Locale(
                            LanguageComponent.languages[1].languageCode,
                            LanguageComponent
                                .languages[1].countryCode));
                        localizationController.setSelectIndex(1);
                      }

                      },
                        value:localizationController.selectIndex==1,active:"English",inActive: "Arabic",),
                      // SizedBox(
                      //   width: 130,
                      //   child:
                      //       LiteRollingSwitch(
                      //         //initial value
                      //         value:false,
                      //         textOn: 'English',
                      //         textOff: 'Arabic',
                      //         colorOn:AppColors.blue_100,
                      //         colorOff:AppColors.black_20 ,
                      //
                      //         iconOn: Icons.language,
                      //         iconOff: Icons.language,
                      //         textSize: 12.0,
                      //         onChanged: (bool state) {
                      //           if(state){
                      //             localizationController.setLanguage(Locale(
                      //                 LanguageComponent.languages[0].languageCode,
                      //                 LanguageComponent
                      //                     .languages[0].countryCode));
                      //             localizationController.setSelectIndex(0);
                      //
                      //           }else{
                      //             localizationController.setLanguage(Locale(
                      //                 LanguageComponent.languages[1].languageCode,
                      //                 LanguageComponent
                      //                     .languages[1].countryCode));
                      //             localizationController.setSelectIndex(1);
                      //           }
                      //
                      //
                      //
                      //
                      //
                      //           print('Current State of SWITCH IS: $state');
                      //         }, onTap:(){
                      //
                      //       }, onDoubleTap:(){
                      //
                      //       }, onSwipe:(){
                      //
                      //       },
                      //
                      //   ),
                      // ),
                      //Customized
                      // AdvancedSwitch(
                      //   controller: _controller,
                      //   activeColor: AppColors.blue_10,
                      //   inactiveColor: AppColors.blue_10,
                      //   activeChild:  Text('English'
                      //   ,style: GoogleFonts.poppins(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w400,
                      //       color: AppColors.black_100
                      //     ),
                      //   ),
                      //   inactiveChild:  Text('Arabic',
                      //   style: GoogleFonts.poppins(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w400,
                      //     color: AppColors.black_100
                      //   ),
                      //   ),
                      //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                      //   width: 90 ,
                      //   height: 30.0,
                      //   enabled: true,
                      //   disabledOpacity: 0.8,
                      // ),
                      //Customized
                    ],
                  ),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.changePasswordScreen);
                    },
                    child:    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.changePassword.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_100,
                        ),
                        CustomImage(imageSrc: AppIcons.chevronRight,
                          size: 18,
                          imageType: ImageType.svg,
                          imageColor: AppColors.black_100,
                        )
                      ],
                    ),),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.termsOfConditionsScreen);
                    },
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.termsOfConditions.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_100,
                        ),
                        CustomImage(imageSrc: AppIcons.chevronRight,
                          size: 18,
                          imageType: ImageType.svg,
                          imageColor: AppColors.black_100,
                        )
                      ],
                    ),),

                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.privacyPolicyScreen);
                    },
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.privacyPolicy.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_100,
                        ),
                        CustomImage(imageSrc: AppIcons.chevronRight,
                          size: 18,
                          imageType: ImageType.svg,
                          imageColor: AppColors.black_100,
                        )
                      ],
                    ),),

                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.aboutUsScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.aboutUs.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_100,
                        ),
                        CustomImage(imageSrc: AppIcons.chevronRight,
                          size: 18,
                          imageType: ImageType.svg,
                          imageColor: AppColors.black_100,
                        )
                      ],
                    ),),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.supportScreen);
                    },
                    child:    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.support.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_100,
                        ),
                        CustomImage(imageSrc: AppIcons.chevronRight,
                          size: 18,
                          imageType: ImageType.svg,
                          imageColor: AppColors.black_100,
                        )
                      ],
                    ),),

                  const SizedBox(height:30,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(onPressed: (){
                        showDialog(context: context, builder:(_)=>AccountDeleteAccount(),

                        );
                        
                        
                        
                        
                      }, child: Text("Delete Account".tr,style: TextStyle(color:Colors.red),)))
                ],
              ),
            );
          }
        );
      },)
    );
  }
}

