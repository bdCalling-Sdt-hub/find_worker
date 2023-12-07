import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/widgets/buttons/custom_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpHomeBottomModalSheet extends StatefulWidget {
  const SpHomeBottomModalSheet({super.key});

  @override
  State<SpHomeBottomModalSheet> createState() => _SpHomeBottomModalSheetState();
}

class _SpHomeBottomModalSheetState extends State<SpHomeBottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 244,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration:const  ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF0668E3)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
        child: Column(
          children: [
            Container(
              child:   Row(
                children: [
                  CustomImage(imageSrc: AppImages.profileJhon,imageType: ImageType.png,size: 65,),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'John Doe',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              color: AppColors.black_60,
                              text: 'location',
                            ),
                            CustomText(
                              text: 'Abu Dhabi',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              color: AppColors.black_60,
                              text: AppStrings.service.tr,
                            ),
                            CustomText(
                              fontSize: 14,
                              text: 'Car Wash',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    onPressed: () {
                      Get.back();
                    },
                    titleText: 'Accept',
                    titleWeight: FontWeight.w600,
                    titleSize: 18,
                    titleColor: AppColors.blue_100,
                    buttonBorderColor: AppColors.blue_100,
                    borderWidth: 1,
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    onPressed: () {
                      Get.back();
                    },
                    titleText: 'Reject',
                    titleWeight: FontWeight.w600,
                    titleSize: 18,
                    titleColor: AppColors.white,
                    buttonBorderColor: AppColors.blue_100,
                    borderWidth: 1,
                    buttonBgColor: AppColors.blue_100,
                  ),
                )
              ],
            )
          ],
        ),
    );
  }
}
