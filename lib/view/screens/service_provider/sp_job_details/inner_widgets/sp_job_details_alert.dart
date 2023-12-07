import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:wrcontacts/view/widgets/buttons/custom_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Binding/provider_bottombar_binding.dart';

class SpJobDetailsAlert extends StatefulWidget {
  const SpJobDetailsAlert({super.key});

  @override
  State<SpJobDetailsAlert> createState() => _SpJobDetailsAlertState();
}

class _SpJobDetailsAlertState extends State<SpJobDetailsAlert> {
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
            text: AppStrings.youHaveCompletedTheJob,
            color: AppColors.blue_100,
            bottom: 24,
          ),
          CustomButton(onPressed: (){
            Get.offAll(SpBottomNavBarScreen(currentIndex: 0),binding:ProviderBottomNavBinding());
          }, titleText: 'Go to Home',buttonBgColor: AppColors.blue_100,buttonHeight: 36,leftPadding: 18,rightPadding: 18,)
        ],
      ),
    );
  }
}