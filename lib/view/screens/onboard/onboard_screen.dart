import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3F3F3),Color(0xFFCCE0FA),],
            ),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              return  SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                child: Column(
                  children: [
                   const SizedBox(height: 44,),
                    const CustomText(
                      text: AppStrings.welcomeToFindWorker,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      bottom: 67,
                    ),
                    const CustomText(
                      text: AppStrings.logo,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue_100,
                      bottom: 66,
                    ),
                    const CustomImage(
                      imageSrc: AppImages.rafiKi,
                      imageType: ImageType.png,
                      size: 258,
                    ),
                    const CustomText(
                      text: AppStrings.loginAs,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue_100,
                      top: 110,
                      bottom: 16,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.userServiceDetailsScreen );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.blue_100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImage(imageSrc: AppIcons.userGroup,size: 24,),
                             CustomText(
                              text: AppStrings.user,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                               left: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.spSignInScreen);
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(width: 1,color: AppColors.blue_100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImage(imageSrc: AppIcons.service,size: 24,),
                            CustomText(
                              text: AppStrings.serviceProvider,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black_100,
                              left: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    ));
  }
}
