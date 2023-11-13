import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_history/Controller/user_history_controller.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHistoryDetailsAlert extends StatefulWidget {
  const UserHistoryDetailsAlert({super.key,required this.id,required this.index});
    final String id;
    final int index;
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
      title: Column(
        children: [
          const CustomText(
            maxLines: 2,
            text: 'Do you want to remove this job details?',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black_100,
            bottom: 24,
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: (){
                      _controller.removeJobHistory(widget.id, widget.index);
                    },
                    child:Obx(() => Container(
                      width: 120,
                        height: 36,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: AppColors.blue_100),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: _controller.removeLoading.value?Container(
                            alignment: Alignment.center,
                            child:  SizedBox(height:20,width:20,child:CircularProgressIndicator(),)) : Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: CustomText(
                            text: AppStrings.yes.tr,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue_100,
                          ),
                        )
                    ),
                  ))
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(

                        decoration: BoxDecoration(
                            color: AppColors.blue_100,
                            borderRadius:
                            BorderRadius.circular(8)),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12),
                          child:CustomText(
                            text: AppStrings.no.tr,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        )),
                  )),
            ],
          )
        ],
      ),
    );
  }
}