
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/advanced_switch/advanced_switch.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class SpSettingScreen extends StatefulWidget {
  const SpSettingScreen({super.key});

  @override
  State<SpSettingScreen> createState() => _SpSettingScreenState();
}

class _SpSettingScreenState extends State<SpSettingScreen> {
  // ...
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar:CustomAppBar(
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    Get.back();
                  },
                  child:  const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18,
                    color: AppColors.blue_100,
                  ),
                ),
                 CustomText(
                  text: "Setting".tr,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue_100,
                ),
                const SizedBox()
              ],
            )),
        body:LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     CustomText(
                      text: "Language".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_100,
                    ),
                    //Customized
                    AdvancedSwitch(
                      controller: _controller,
                      activeColor: AppColors.blue_10,
                      inactiveColor: AppColors.blue_10,
                      activeChild:  Text('Arabic'.tr,style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_100
                        ),
                      ),
                      inactiveChild:  Text('English'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_100
                        ),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      width: 90,
                      height: 30.0,
                      disabledOpacity: 0.8,
                    ),
                    //Customized
                  ],
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.spChangePasswordScreen);
                  },
                  child:    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text:'Change Password'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                      ),
                      const CustomImage(imageSrc: AppIcons.chevronRight,
                        size: 18,
                        imageType: ImageType.svg,
                        imageColor: AppColors.black_100,
                      )
                    ],
                  ),),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.spTermsOfConditionsScreen);
                  },
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Terms of Conditions".tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                      ),
                      const CustomImage(imageSrc: AppIcons.chevronRight,
                        size: 18,
                        imageType: ImageType.svg,
                        imageColor: AppColors.black_100,
                      )
                    ],
                  ),),

                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.spPrivacyPolicyScreen);
                  },
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Privacy Policy'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                      ),
                      const CustomImage(imageSrc: AppIcons.chevronRight,
                        size: 18,
                        imageType: ImageType.svg,
                        imageColor: AppColors.black_100,
                      )
                    ],
                  ),),

                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.spAboutUsScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'About us'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                      ),
                      const CustomImage(imageSrc: AppIcons.chevronRight,
                        size: 18,
                        imageType: ImageType.svg,
                        imageColor: AppColors.black_100,
                      )
                    ],
                  ),),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.spSupportScreen);
                  },
                  child:    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Support'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100,
                      ),
                      const CustomImage(imageSrc: AppIcons.chevronRight,
                        size: 18,
                        imageType: ImageType.svg,
                        imageColor: AppColors.black_100,
                      )
                    ],
                  ),),

                const SizedBox(height:30,),
                // ElevatedButton(onPressed: (){
                //   Get.updateLocale( Locale("en","US"));
                // }, child: Text("english")),
                // ElevatedButton(onPressed: (){
                //   Get.updateLocale( Locale("ar","SA"));
                // }, child: Text("Arabi")),
              ],
            ),
          );
        },)
    );
  }
}