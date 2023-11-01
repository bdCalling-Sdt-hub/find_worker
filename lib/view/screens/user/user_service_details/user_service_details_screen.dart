import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_service_details/inner_widgets/user_service_details_hire_now_bottom_modal.dart';
import 'package:find_worker/view/screens/user/user_service_details/inner_widgets/user_service_details_rate_us_alert.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserServiceDetailsScreen extends StatefulWidget {
  const UserServiceDetailsScreen({super.key});

  @override
  State<UserServiceDetailsScreen> createState() =>
      _UserServiceDetailsScreenState();
}

class _UserServiceDetailsScreenState extends State<UserServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 16,
                    color: AppColors.blue_100,
                  ),
                ),
                 CustomText(
                  text: "Service Details".tr,
                  color: AppColors.blue_100,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox()
              ],
            ),
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/hire_details_profile.png'),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'John Doe',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.star,
                              size: 12,
                            ),
                            CustomText(
                              text: '(4.5)',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Location'.tr,
                        ),
                        CustomText(
                          text: 'Abu Dhabi',
                          fontWeight: FontWeight.w600,
                          left: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Service".tr,
                        ),
                        CustomText(
                          text: AppStrings.carWash,
                          fontWeight: FontWeight.w600,
                          left: 4,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      height: 1,
                      color: AppColors.blue_20,
                    ),
                     CustomText(
                      text: 'Top Reviews'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      bottom: 16,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Smith',
                        ),
                        Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.star,
                              size: 12,
                            ),
                            CustomText(
                              text: '(4.5)',
                              fontSize: 12,
                              left: 4,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Nice services!',
                          fontSize: 12,
                          color: AppColors.black_60,
                        ),
                        CustomText(
                          fontSize: 12,
                          color: AppColors.black_60,
                          left: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Smith',
                        ),
                        Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.star,
                              size: 12,
                            ),
                            CustomText(
                              text: '(4.5)',
                              fontSize: 12,
                              left: 4,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Nice services!',
                          fontSize: 12,
                          color: AppColors.black_60,
                        ),
                        CustomText(
                          text: '01 aug',
                          fontSize: 12,
                          color: AppColors.black_60,
                          left: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Smith',
                        ),
                        Row(
                          children: [
                            CustomImage(
                              imageSrc: AppIcons.star,
                              size: 12,
                            ),
                            CustomText(
                              text: '(4.5)',
                              fontSize: 12,
                              left: 4,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Nice services!',
                          fontSize: 12,
                          color: AppColors.black_60,
                        ),
                        CustomText(
                          text: '01 aug',
                          fontSize: 12,
                          color: AppColors.black_60,
                          left: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      height: 1,
                      color: AppColors.blue_20,
                    ),
                      CustomText(
                      text: 'Description'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      bottom: 16,
                    ),
                    const CustomText(
                      text: AppStrings.loremIpsumDolor,
                      maxLines: 9,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 24,),
                    Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: CustomButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return const UserServiceDetailsRateUsAlert();
                                    }
                                );
                              },
                              titleText: 'Rate Us'.tr,
                              titleWeight: FontWeight.w600,
                              titleSize: 18,
                              titleColor: AppColors.blue_100,
                              buttonBorderColor: AppColors.blue_100,
                              borderWidth: 1,
                              leftPadding: 32,
                            rightPadding: 32,
                          ),
                        ),
                       const SizedBox(width: 16,),
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                                    return const UserServiceDetailsHireNoeBottomModal();
                                  });
                            },
                            titleText: 'Hire Now'.tr,
                            titleWeight: FontWeight.w600,
                            titleSize: 18,
                            titleColor: AppColors.white,
                            buttonBorderColor: AppColors.blue_100,
                            borderWidth: 1,
                            leftPadding: 60,
                            rightPadding: 60,
                            buttonBgColor: AppColors.blue_100,
                          ),
                        )
                      ],
                    )
                  ],
                ));
          }),
        ));
  }
}
