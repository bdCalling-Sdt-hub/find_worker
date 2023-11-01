import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserServiceDetailsRateUsAlert extends StatefulWidget {
  const UserServiceDetailsRateUsAlert({super.key});

  @override
  State<UserServiceDetailsRateUsAlert> createState() => _UserServiceDetailsRateUsAlertState();
}

class _UserServiceDetailsRateUsAlertState extends State<UserServiceDetailsRateUsAlert> {
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
            CustomText(
            text: 'Give rating out of 5!'.tr,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            top: 24,
            bottom: 24,
          ),
          RatingBar.builder(
            itemSize: 30,
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
            },
          ),
          const SizedBox(height: 16,),
          CustomTextField(
            maxLines: 3,
            textAlign: TextAlign.start,
            hintText: 'Write your feedback'.tr,
            hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black_40),
            inputTextStyle: GoogleFonts.poppins(
                color: AppColors.black_100),
            fieldBorderColor: AppColors.blue_60,
            fieldBorderRadius: 8,

          ),
          const SizedBox(height: 24,),
          CustomButton(onPressed: (){
            Navigator.pop(context);
          }, titleText: 'Submit'.tr,buttonBgColor: AppColors.blue_100,buttonHeight: 36,leftPadding: 34,rightPadding: 34,)
        ],
      ),
    );
  }
}