import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_hire_list/Controller/hire_controller.dart';
import 'package:wrcontacts/view/widgets/custom_outline_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:wrcontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../widgets/custom_button.dart';

class UserServiceDetailsRateUsAlert extends StatefulWidget {
  UserServiceDetailsRateUsAlert(
      {super.key, required this.userUid, required this.serviceId});

  String userUid;
  String serviceId;

  @override
  State<UserServiceDetailsRateUsAlert> createState() =>
      _UserServiceDetailsRateUsAlertState();
}

class _UserServiceDetailsRateUsAlertState
    extends State<UserServiceDetailsRateUsAlert> {
  final _hireController = Get.put(HireController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      content: Form(
        key: _hireController.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomImage(
                imageSrc: AppImages.success,
                imageType: ImageType.png,
                size: 100,
              ),
              CustomText(
                text: AppStrings.giveRatingOutOf.tr,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                top: 24,
                bottom: 24,
              ),
              RatingBar(
                initialRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset("assets/icons/star.svg"),
                  half: SvgPicture.asset("assets/icons/star_unreat.svg"),
                  empty: SvgPicture.asset("assets/icons/star_unreat.svg"),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  _hireController.rating.value = rating;
                },
              ),
              const SizedBox(
                height: 20,
                width: double.maxFinite,
              ),
              CustomTextField(
                maxLines: 3,
                textEditingController: _hireController.feedbackController,
                textAlign: TextAlign.start,
                hintText: AppStrings.writeYourFeedback.tr,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Field is empty!";
                  }
                  return null;
                },
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_40),
                inputTextStyle: GoogleFonts.poppins(color: AppColors.black_100),
                fieldBorderColor: AppColors.blue_60,
                fieldBorderRadius: 8,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                        onTap:(){
                          Get.back();
                        },
                        text: AppStrings.cancel.tr,
                        height: 36.h),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Obx(
                      () => CustomButton(
                        onTap: () {
                          _hireController.sendReview(
                              widget.userUid, widget.serviceId);
                        },
                        loading: _hireController.ratingLoading.value,
                        text: AppStrings.submit.tr,

                        height: 36.h,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
