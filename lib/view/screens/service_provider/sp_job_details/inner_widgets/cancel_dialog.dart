import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_details/controller/sp_job_details_controller.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpJobDetailsCancelDialog extends StatelessWidget {
  SpJobDetailsCancelDialog({super.key});
  final _spJobDetailsController = Get.put(SpJobDetailsController());
  @override
  Widget build(BuildContext context) {
    return
       AlertDialog(
        title: Text(AppStrings.doYouWantToCancelThisWork.tr,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
        contentPadding: EdgeInsets.symmetric(vertical: 24.h,horizontal: 24.w),
        actions: [
          CustomButton(onTap:(){
          Get.back();
          },width: 120.w, text:AppStrings.no.tr),
          SizedBox(width: 24.w,),
          Obx(()=>
             CustomOutlineButton(onTap:(){
              _spJobDetailsController.cancelService(_spJobDetailsController.jobDetails.value);
            },
                loading: _spJobDetailsController.cancelWorkLoading.value,text: AppStrings.yes.tr,width: 120.w,
               ),
          )
        ],

    );
  }
}
