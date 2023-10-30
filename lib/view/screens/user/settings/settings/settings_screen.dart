
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



class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
               const CustomText(
                text: AppStrings.settings,
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
                  const CustomText(
                    text: AppStrings.language,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_100,
                  ),
                  //Customized
                  AdvancedSwitch(
                    controller: _controller,
                    activeColor: AppColors.blue_10,
                    inactiveColor: AppColors.blue_10,
                    activeChild:  Text('English'
                    ,style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_100
                      ),
                    ),
                    inactiveChild:  Text('Arabic',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_100
                    ),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    width: 90 ,
                    height: 30.0,
                    enabled: true,
                    disabledOpacity: 0.8,
                  ),
                  //Customized
                ],
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoute.changePasswordScreen);
                },
                child:   const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppStrings.changePassword,
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
                child:  const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Terms of Conditions",
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
                child:  const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppStrings.privacyPolicy,
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
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppStrings.aboutUs,
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
                child:   const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppStrings.support,
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
            ],
          ),
        );
      },)
    );
  }
}