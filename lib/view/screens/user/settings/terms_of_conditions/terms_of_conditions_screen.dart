import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/settings/Controller/setting_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_back.dart';


class TermsOfConditionsScreen extends StatefulWidget {
  const TermsOfConditionsScreen({super.key});

  @override
  State<TermsOfConditionsScreen> createState() => _TermsOfConditionsScreenState();
}

class _TermsOfConditionsScreenState extends State<TermsOfConditionsScreen> {

  final _settingController = Get.put(SettingController());


  @override
  void initState() {
   _settingController.getTermsOfCondition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppStrings.termsOfConditions.tr),
        leading: CustomBack(),
      ),
      // appBar: CustomAppBar(
      //     appBarContent: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         GestureDetector(
      //           onTap:(){
      //             Get.back();
      //           },
      //           child:  const Icon(
      //             Icons.arrow_back_ios_new_outlined,
      //             size: 18,
      //             color: AppColors.blue_100,
      //           ),
      //         ),
      //         const CustomText(
      //           text: "Terms of Conditions",
      //           fontSize: 18,
      //           fontWeight: FontWeight.w500,
      //           color: AppColors.blue_100,
      //         ),
      //         const SizedBox()
      //       ],
      //     )),
      body: Obx(()=>_settingController.otherLoading.value?const CustomLoader() :
         LayoutBuilder(
            builder: (BuildContext context,BoxConstraints constraints){
              return SingleChildScrollView(
                  padding:  EdgeInsets.symmetric(vertical:24,horizontal: 20.w),
                  child:Html(data:_settingController.termsOfCondition.value, ),
                  // child: Column(
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CustomText(
                  //           text: '1.',
                  //           color: AppColors.black_100,
                  //           right: 4,
                  //         ),
                  //
                  //         Expanded(
                  //           child: CustomText(
                  //             textAlign: TextAlign.start,
                  //             maxLines: 10,
                  //             text: AppStrings.loremIpsumDolor,
                  //             color: AppColors.black_100,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 8,),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CustomText(
                  //           text: '2.',
                  //           color: AppColors.black_100,
                  //           right: 4,
                  //         ),
                  //
                  //         Expanded(
                  //           child: CustomText(
                  //             textAlign: TextAlign.start,
                  //             maxLines: 10,
                  //             text: AppStrings.loremIpsumDolor,
                  //             color: AppColors.black_100,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 8,),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CustomText(
                  //           text: '3.',
                  //           color: AppColors.black_100,
                  //           right: 4,
                  //         ),
                  //
                  //         Expanded(
                  //           child: CustomText(
                  //             textAlign: TextAlign.start,
                  //             maxLines: 10,
                  //             text: AppStrings.loremIpsumDolor,
                  //             color: AppColors.black_100,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 8,),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CustomText(
                  //           text: '4.',
                  //           color: AppColors.black_100,
                  //           right: 4,
                  //         ),
                  //
                  //         Expanded(
                  //           child: CustomText(
                  //             textAlign: TextAlign.start,
                  //             maxLines: 10,
                  //             text: AppStrings.loremIpsumDolor,
                  //             color: AppColors.black_100,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 8,),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         CustomText(
                  //           text: '5.',
                  //           color: AppColors.black_100,
                  //           right: 4,
                  //         ),
                  //         Flexible(
                  //           child: CustomText(
                  //             textAlign: TextAlign.start,
                  //             maxLines: 10,
                  //             text: AppStrings.loremIpsumDolor,
                  //             color: AppColors.black_100,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
              );
            }
        ),
      ),
    );
  }
}