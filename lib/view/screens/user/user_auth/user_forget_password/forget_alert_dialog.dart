import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/text/custom_text.dart';

class ForgetAlertDialog extends StatelessWidget {
  const ForgetAlertDialog({super.key});

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
         const SizedBox(height: 10,),
          const CustomText(
            text:'We have send you email to recover password, please check email.',  color: AppColors.blue_100,
            maxLines: 5,
            bottom: 24,
          ),
            CustomButton(
              width: 100,
              height: 36,
              onTap: (){
                Get.back();
                Get.back();
              },text:"Ok",)
         
           ],
      ),
    );
  }
  
}