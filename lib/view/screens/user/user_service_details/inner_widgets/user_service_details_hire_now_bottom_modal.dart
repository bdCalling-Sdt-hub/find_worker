import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_service_details/inner_widgets/user_service_details_hire_cancel_alert.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserServiceDetailsHireNoeBottomModal extends StatefulWidget {
  const UserServiceDetailsHireNoeBottomModal({super.key});

  @override
  State<UserServiceDetailsHireNoeBottomModal> createState() => _UserServiceDetailsHireNoeBottomModalState();
}

class _UserServiceDetailsHireNoeBottomModalState extends State<UserServiceDetailsHireNoeBottomModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration:const  ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF0668E3)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: Column(
        children: [
          const CustomText(
            text: AppStrings.pending,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            bottom: 20,
          ),
           LinearPercentIndicator(
            linearGradient:const LinearGradient(
                colors: [
                  Color(0xff9DC9FF),
                  Color(0xff0668E3),

                ]
            ),

             backgroundColor: AppColors.black_10,
             barRadius:const Radius.circular(4),
            animation: true,
            animationDuration: 1000,
            lineHeight: 8.0,
            percent: 0.5,
            linearStrokeCap: LinearStrokeCap.butt,
          ),
          const SizedBox(height: 8,),
          const CustomText(
            text: AppStrings.keepPatienceWaitingForApproval,
            color: AppColors.black_60,
            bottom: 40,
          ),
          CustomButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext contect){
                    return const UserServiceDetailsHireCancelAlert();
                  });
             
            },
            titleText: 'Cancel',
            buttonWidth: MediaQuery.of(context).size.width,
            buttonBgColor: AppColors.blue_100,
          ),
          const CustomText(
            text: AppStrings.or,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            bottom: 20,
            top: 20,
          ),
          GestureDetector(
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(width: 1,color: AppColors.blue_100),
                borderRadius: BorderRadius.circular(8),
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImage(imageSrc: AppIcons.phone,size: 24,imageColor: AppColors.blue_100,),
                  CustomText(
                    text: AppStrings.directCall,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue_100,
                    left: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
