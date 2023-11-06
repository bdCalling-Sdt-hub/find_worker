import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpHistoryDetailsAlert extends StatefulWidget {
  const SpHistoryDetailsAlert({super.key});

  @override
  State<SpHistoryDetailsAlert> createState() => _SpHistoryDetailsAlertState();
}

class _SpHistoryDetailsAlertState extends State<SpHistoryDetailsAlert> {
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
                  child:InkWell(
                    onTap: (){
                      Get.to(SpBottomNavBarScreen(currentIndex: 1));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: AppColors.blue_100),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: CustomText(
                            text: AppStrings.yes,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue_100,
                          ),
                        )
                    ),
                  )
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12),
                          child:CustomText(
                            text: AppStrings.no,
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