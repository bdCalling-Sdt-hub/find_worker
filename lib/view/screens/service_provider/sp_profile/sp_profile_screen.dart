import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/inner_widgets/sp_profile_log_out_alert.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfileScreen extends StatefulWidget {
  const SpProfileScreen({super.key});

  @override
  State<SpProfileScreen> createState() => _SpProfileScreenState();
}

class _SpProfileScreenState extends State<SpProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar:  CustomAppBar(
              appBarBgColor: AppColors.blue_100,
              appBarContent: Center(
                child:  CustomText(
                  text: 'Profile'.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.white,
                ),
              )),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsets.only(top: 24,bottom: 24),
                          width: MediaQuery.of(context).size.width,
                          decoration:const BoxDecoration(
                              color: AppColors.blue_100,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16)
                              )
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/images/profile_smith.png'),
                                    )
                                ),
                              ),
                              const CustomText(
                                text: 'Smith John',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: AppColors.white,
                                top: 24,
                                bottom: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomText(
                                  text: 'Service Provider'.tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.blue_100,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.spPersonalInformationScreen);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.only(bottom: 16),
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                    ),
                                    child:   Row(
                                      children: [
                                        CustomImage(imageSrc: AppIcons.user,size: 18,),
                                        CustomText(
                                          text:'Personal Information'.tr,
                                          left: 12,
                                          right: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.spServiceDetailsScreen);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.only(bottom: 16),
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                    ),
                                    child:   Row(
                                      children: [
                                        CustomImage(imageSrc: AppIcons.service,size: 18,imageColor: AppColors.black_100,),
                                        CustomText(
                                          text: 'Service Provider'.tr,
                                          left: 12,
                                          right: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.spSettingScreen);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.only(bottom: 16),
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                    ),
                                    child:   Row(
                                      children: [
                                        CustomImage(
                                          imageType: ImageType.png,
                                          imageSrc: AppImages.settings,size: 18,
                                        ),
                                        CustomText(
                                          text: 'Setting'.tr,
                                          left: 12,
                                          right: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return const SpProfileLogOutAlert();
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.only(bottom: 16),
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                    ),
                                    child:   Row(
                                      children: [
                                        CustomImage(imageSrc: AppIcons.logout,size: 18,imageColor: AppColors.red_100,),
                                        CustomText(
                                          text: 'Logout'.tr,
                                          color: AppColors.red_100,
                                          left: 12,
                                          right: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                );
              }),
        ));
  }
}
