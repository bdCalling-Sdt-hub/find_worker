import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/bottom_nav_button.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpServiceDetailsScreen extends StatefulWidget {
  const SpServiceDetailsScreen({super.key});

  @override
  State<SpServiceDetailsScreen> createState() =>
      _SpServiceDetailsScreenState();
}

class _SpServiceDetailsScreenState extends State<SpServiceDetailsScreen> {
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
                  text: 'Service Details'.tr,
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
                              text: 'Service'.tr,
                            ),
                            CustomText(
                              text: AppStrings.carWash,
                              fontWeight: FontWeight.w600,
                              left: 4,
                            ),
                          ],
                        ),
                         CustomText(
                          text: 'Description'.tr,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          bottom: 8,
                          top: 16,
                        ),
                        const CustomText(
                          text: AppStrings.loremIpsumDolor,
                          maxLines: 9,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ));
              }),
          bottomNavigationBar: BottomNavButton(buttonText: 'Edit'.tr, onTap: (){
            Get.toNamed(AppRoute.spEditServiceDetailsScreen);
          })
        ));
  }
}
