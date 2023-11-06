import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserServiceDetailsHireCancelAlert extends StatefulWidget {
  const UserServiceDetailsHireCancelAlert({super.key});

  @override
  State<UserServiceDetailsHireCancelAlert> createState() => _UserServiceDetailsHireCancelAlertState();
}

class _UserServiceDetailsHireCancelAlertState extends State<UserServiceDetailsHireCancelAlert> {
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
          const CustomImage(imageSrc: AppIcons.oops,imageType: ImageType.svg,size: 100,),
          const CustomText(
            text: 'Oops...Something went wrong',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.blue_100,
            top: 24,
            bottom: 24,
          ),
          CustomButton(onPressed: (){
            Get.back();
          },
            titleText: 'Try Again',buttonBgColor: AppColors.blue_100,buttonHeight: 36,leftPadding: 18,rightPadding: 18,)
        ],
      ),
    );
  }
}