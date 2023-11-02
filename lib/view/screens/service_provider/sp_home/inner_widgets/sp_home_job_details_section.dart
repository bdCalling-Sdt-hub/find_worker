import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpHomeJobDetailsSection extends StatefulWidget {
  const SpHomeJobDetailsSection({super.key});

  @override
  State<SpHomeJobDetailsSection> createState() => _SpHomeJobDetailsSectionState();
}

class _SpHomeJobDetailsSectionState extends State<SpHomeJobDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoute.spJobDetailsScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.blue_100,width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Nadim Hasan',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              bottom: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Status'.tr,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 11),
                  decoration: BoxDecoration(
                      color: AppColors.yellow_10,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: const CustomText(
                    text: AppStrings.pending,
                    fontSize: 12,
                    color: AppColors.yellow_100,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Service'.tr,
                ),
                const CustomText(
                  text: AppStrings.carWash,
                  fontWeight: FontWeight.w500,
                  left: 4,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Time'.tr,
                ),
                const CustomText(
                  text: '12:00 am',
                  fontWeight: FontWeight.w500,
                  left: 4,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Date'.tr,
                ),
                const CustomText(
                  text: '12 September',
                  fontWeight: FontWeight.w500,
                  left: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
