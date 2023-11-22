 import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_back.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../Controller/setting_controller.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final _settingController = Get.put(SettingController());


  @override
  void initState() {
    _settingController.getAboutUs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppStrings.aboutUs.tr),
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
      //          CustomText(
      //           text: AppStrings.aboutUs.tr,
      //           fontSize: 18,
      //           fontWeight: FontWeight.w500,
      //           color: AppColors.blue_100,
      //         ),
      //         const SizedBox()
      //       ],
      //     )),
      body: Obx(()=>_settingController.otherLoading.value?CustomLoader():
         LayoutBuilder(
            builder: (BuildContext context,BoxConstraints constraints){
              return  SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                child:Html(data:_settingController.aboutUs.value, ),
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