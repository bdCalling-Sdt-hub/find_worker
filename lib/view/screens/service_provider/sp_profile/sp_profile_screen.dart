import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_profile/Controller/profile_controller.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_profile/inner_widgets/sp_profile_log_out_alert.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/SystemChromeHelper/system_chrome.dart';
import '../sp_services/sp_services_screen.dart';

class SpProfileScreen extends StatefulWidget {
  const SpProfileScreen({super.key});

  @override
  State<SpProfileScreen> createState() => _SpProfileScreenState();
}

class _SpProfileScreenState extends State<SpProfileScreen> {

  final _profileController = Get.put(SpProfileController());
  @override
  void initState() {
      SystemChromeHelper.blueColorSystemChrome();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChromeHelper.enableSystemChrome();
    super.dispose();
  }

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
                  text: AppStrings.profile.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.white,
                ),
              )),
          body: Obx(()=>_profileController.loading.value?const CustomLoader():
             LayoutBuilder(
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
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                      image: _profileController
                                          .userData.value.imageSrc !=
                                          null
                                          ? _profileController
                                          .userData.value.imageSrc !=
                                          ""
                                          ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              _profileController.userData
                                                  .value.imageSrc!))
                                          : DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/person.png'),
                                      )
                                          : DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/person.png'),
                                      )),
                                ),
                                CustomText(
                                  text: _profileController
                                      .userData.value.userName ==
                                      null
                                      ? ""
                                      : _profileController
                                      .userData.value.userName!,
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
                                  child:   CustomText(
                                    text: AppStrings.serviceProvider.tr,
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
                                            text: AppStrings.personalInformation.tr,
                                            left: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                Get.to(SpServicesScreen());
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
                                            text: AppStrings.serviceProvider.tr,
                                            left: 12,
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
                                            text: AppStrings.settings.tr,
                                            left: 12,
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
                                            text: AppStrings.logout.tr,
                                            color: AppColors.red_100,
                                            left: 12,
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
          ),
        ));
  }
}
