import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_job_history/Controller/sp_history_controller.dart';
import 'package:wrcontacts/view/widgets/custom_button.dart';
import 'package:wrcontacts/view/widgets/custom_outline_button.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpHistoryDetailsAlert extends StatefulWidget {
  const SpHistoryDetailsAlert({super.key,required this.id,});
  final String id;


  @override
  State<SpHistoryDetailsAlert> createState() => _SpHistoryDetailsAlertState();
}

class _SpHistoryDetailsAlertState extends State<SpHistoryDetailsAlert> {

  final _controller=Get.put(SpHistoryController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      elevation: 0,

      title: Text(AppStrings.doYouWantToRemoveThisJobDetails.tr,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
      actions: [
        Obx(()=>
           CustomOutlineButton(onTap: (){
            _controller.removeJobHistory(widget.id);
          }, text:AppStrings.yes.tr,width: 120.w,loading:_controller.removeLoading.value,),
        ),
        SizedBox(width: 24.w,),
        CustomButton(onTap:(){
          Get.back();
        }, text:AppStrings.no.tr,width: 120.w,)
      ],
      // title: Column(
      //   children: [
      //     const CustomText(
      //       maxLines: 2,
      //       text: 'Do you want to remove this job details?',
      //       fontWeight: FontWeight.w600,
      //       fontSize: 18,
      //       color: AppColors.black_100,
      //       bottom: 24,
      //     ),
      //     Row(
      //       children: [
      //         Expanded(
      //             child: InkWell(
      //                 onTap: (){
      //                   _controller.removeJobHistory(widget.id,);
      //                 },
      //                 child:Obx(() => Container(
      //                     width: 120,
      //                     height: 36,
      //                     decoration: BoxDecoration(
      //                         border: Border.all(width: 1,color: AppColors.blue_100),
      //                         borderRadius: BorderRadius.circular(8)
      //                     ),
      //                     child: _controller.removeLoading.value?Container(
      //                         alignment: Alignment.center,
      //                         child:  const SizedBox(height:20,width:20,child:CircularProgressIndicator(),)) : Padding(
      //                       padding: const EdgeInsets.symmetric(vertical: 12),
      //                       child: CustomText(
      //                         text: AppStrings.yes.tr,
      //                         fontWeight: FontWeight.w600,
      //                         color: AppColors.blue_100,
      //                       ),
      //                     )
      //                 ),
      //                 ))
      //         ),
      //         const SizedBox(
      //           width: 8,
      //         ),
      //         Expanded(
      //             child: InkWell(
      //               onTap: (){
      //                 Navigator.pop(context);
      //               },
      //               child: Container(
      //
      //                   decoration: BoxDecoration(
      //                       color: AppColors.blue_100,
      //                       borderRadius:
      //                       BorderRadius.circular(8)),
      //                   child:  Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: 12),
      //                     child:CustomText(
      //                       text: AppStrings.no.tr,
      //                       fontWeight: FontWeight.w600,
      //                       color: AppColors.white,
      //                     ),
      //                   )),
      //             )),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}