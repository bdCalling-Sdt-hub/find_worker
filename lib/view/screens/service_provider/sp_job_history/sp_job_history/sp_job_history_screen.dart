import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpJobHistoryScreen extends StatefulWidget {
  const SpJobHistoryScreen({super.key});

  @override
  State<SpJobHistoryScreen> createState() => _SpJobHistoryScreenState();
}

class _SpJobHistoryScreenState extends State<SpJobHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            color: AppColors.blue_100,
             fontWeight: FontWeight.w500,
              fontSize: 18,
              text: AppStrings.jobHistory
          ),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return  SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
            child: Column(
              children: [
                // this page will show when there is no data
                /*Center(
                  heightFactor: 6,
                  child: Column(
                    children: [
                      CustomImage(
                        size: 80,
                        imageType: ImageType.png,
                        imageSrc: AppImages.empty,
                      ),
                      CustomText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        text: "No jobs here yet.",
                      )
                    ],
                  ),
                ),*/

                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration:const BoxDecoration(
                       color: AppColors.blue_100,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16),

                     child:const CustomText(
                       color: AppColors.white,
                       textAlign: TextAlign.start,
                       text: "Recent Jobs",
                       fontWeight: FontWeight.w500,
                       fontSize: 18,
                     ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.spHistoryDetailsScreen);
                      },
                      child: Column(
                        children: List.generate(20, (index) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFFE7F0FD)),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: 'Smith John',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                right: 16,
                              ),
                             const CustomImage(
                                  imageSrc: AppIcons.calendar
                              ),
                              const CustomText(
                                left: 4,
                                text:  '12-Sept',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                right: 4,
                              ),
                              const CustomImage(
                                  imageSrc: AppIcons.clock
                              ),
                              const CustomText(
                                left: 4,
                                text: '12:00 AM',
                                textAlign: TextAlign.right,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                right: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: AppColors.green_10,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                                child: const CustomText(
                                  color: AppColors.green_100,
                                  text:  'Complete',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),),
                      ),
                    ),
                  ],
                )

              ],
            ),
          );
        },),
      ),
    );
  }
}
