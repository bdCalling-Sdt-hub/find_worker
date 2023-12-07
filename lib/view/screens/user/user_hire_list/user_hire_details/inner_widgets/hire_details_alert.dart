import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:wrcontacts/view/widgets/buttons/custom_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Binding/user_bottom_binding.dart';

class HireDetailsAlert extends StatefulWidget {
  const HireDetailsAlert({super.key});

  @override
  State<HireDetailsAlert> createState() => _HireDetailsAlertState();
}

class _HireDetailsAlertState extends State<HireDetailsAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      elevation: 0,
      title: Column(
        children: [
            const CustomImage(imageSrc: AppImages.success,imageType: ImageType.png,size: 100,),
          const CustomText(
            text: AppStrings.congratulations,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.blue_100,
            top: 24,
            bottom: 24,
          ),
          const CustomText(
            text: 'Your service has been completed successfully.',
            color: AppColors.blue_100,
            bottom: 24,
          ),
          CustomButton(onPressed: (){
            Get.offAll(UserBottomNavBarScreen(currentIndex: 0),binding:UserBottomNavBinding());
          }, titleText: 'Go to Home',buttonBgColor: AppColors.blue_100,buttonHeight: 36,leftPadding: 18,rightPadding: 18,)
        ],
      ),
    );
  }
}