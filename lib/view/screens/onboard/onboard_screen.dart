import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helper/SystemChromeHelper/system_chrome.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      top: false,
      child: Container(
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 70.h,),
                   CustomText(
                    text: AppStrings.welcomeToFindWorker,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    bottom: 30.h,
                  ),

                  SizedBox(height: 70.h,),
                   CustomImage(
                    imageSrc: AppImages.rafiKi,
                    imageType: ImageType.png,
                    size: 250.h,
                  ),
                   CustomText(
                    text: AppStrings.loginAs,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue_100,
                    top: 110.h,
                    bottom: 16.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.userSignIn,arguments:AppConstants.userType);
                    },
                    child: Container(
                      margin:  EdgeInsets.only(bottom: 16.h),
                      height: 56.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.blue_100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppIcons.userGroup,size: 24.h
                            ,),
                           CustomText(
                            text: AppStrings.user,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                             left: 12.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.userSignIn,arguments:AppConstants.serviceProviderType);
                    },
                    child: Container(
                      height: 56.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(width: 1,color: AppColors.blue_100),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppIcons.service,size: 24.h,),
                          CustomText(
                            text: AppStrings.serviceProvider,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_100,
                            left: 12.w,
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
    ),
    );
  }
}
