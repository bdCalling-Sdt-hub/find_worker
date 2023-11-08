import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/custom_button.dart';
import '../Controller/user_service_details_controller.dart';

class UserServiceDetailsRateUsAlert extends StatefulWidget {
   UserServiceDetailsRateUsAlert({super.key,required this.userUid,required this.serviceId});

    String userUid;
    String serviceId;

  @override
  State<UserServiceDetailsRateUsAlert> createState() => _UserServiceDetailsRateUsAlertState();
}

class _UserServiceDetailsRateUsAlertState extends State<UserServiceDetailsRateUsAlert> {
  final _userServiceDetailsController = Get.put(UserServiceDetailsController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      elevation: 0,
      content: Form(
        key: _userServiceDetailsController.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomImage(imageSrc: AppImages.success,imageType: ImageType.png,size: 100,),
              const CustomText(
                text: AppStrings.giveRatingOutOf,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                top: 24,
                bottom: 24,
              ),
          RatingBar(
            initialRating:1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize:30,
            ratingWidget: RatingWidget(
              full:SvgPicture.asset("assets/icons/star.svg"),
              half: SvgPicture.asset("assets/icons/star_unreat.svg"),
              empty:SvgPicture.asset("assets/icons/star_unreat.svg"),
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              _userServiceDetailsController.rating.value=rating;
            },
          ),

              const SizedBox(height: 20,width: double.maxFinite,),

              CustomTextField(
                maxLines: 3,
                textEditingController:_userServiceDetailsController.feedbackController,
                textAlign: TextAlign.start,
                hintText: AppStrings.writeYourFeedback,
                validator: (val){
                  if(val!.isEmpty){
                    return "Field is empty!";
                  }
                  return null;
                },
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
              Obx(()=>
                 CustomButton(onTap: (){
                  _userServiceDetailsController.sendReview(widget.userUid,widget.serviceId);
                },
                  loading: _userServiceDetailsController.ratingLoading.value
                  , text: AppStrings.submit,width: 120,height: 36,),
              )
            ],
          ),
        ),
      ),
    );
  }
}