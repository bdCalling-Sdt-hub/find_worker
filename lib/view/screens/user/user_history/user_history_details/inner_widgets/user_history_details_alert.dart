import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_history/Controller/user_history_controller.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/custom_outline_button.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserHistoryDetailsAlert extends StatefulWidget {
  const UserHistoryDetailsAlert({super.key,required this.id,});
    final String id;

  @override
  State<UserHistoryDetailsAlert> createState() => _UserHistoryDetailsAlertState();
}

class _UserHistoryDetailsAlertState extends State<UserHistoryDetailsAlert> {
  final _controller = Get.put(UserHistoryController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      elevation: 0,
      actions: [
        Obx(()=>
           CustomOutlineButton(onTap:(){
            _controller.removeJobHistory(widget.id,);
          }, text:AppStrings.yes.tr,
            loading: _controller.removeLoading.value
            ,height: 36.h,width: 120.w,),
        ),
        SizedBox(width: 16.w,),
        CustomButton(onTap:(){
          Get.back();
        }, text:AppStrings.no.tr,height: 36.h,width: 120.w,)


      ],
      title:  CustomText(
        maxLines:2,
        text:AppStrings.doYouWantToRemoveThisJobDetails.tr,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: AppColors.black_100,
      ),
    );
  }
}