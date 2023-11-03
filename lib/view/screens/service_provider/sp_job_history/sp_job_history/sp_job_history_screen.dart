import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpJobHistoryScreen extends StatefulWidget {
  const SpJobHistoryScreen({super.key});

  @override
  State<SpJobHistoryScreen> createState() => _SpJobHistoryScreenState();
}

class _SpJobHistoryScreenState extends State<SpJobHistoryScreen> {
  int selected=2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  CustomText(
            color: AppColors.blue_100,
             fontWeight: FontWeight.w500,
              fontSize: 18,
            text: 'Job Details'.tr,
          ),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return  SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:const BoxDecoration(
                    color: AppColors.blue_100,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.only(left: 12,top: 16,bottom: 16),

                  child: CustomText(
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    text: "Recent Jobs".tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    left: 16,
                    right: 16,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.spHistoryDetailsScreen);
                  },
                  child: Column(
                    children: List.generate(20, (index) =>
                        GestureDetector(
                          onTap: (){
                            setState(() {

                            });
                          },
                          child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                      decoration:  ShapeDecoration(
                          color:index % 2 == 0 ? AppColors.black_5 : AppColors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFE7F0FD)),
                          ),
                      ),
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CustomText(
                              text: 'Smith John',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const Row(
                              children: [
                             Row(
                               children: [
                                 CustomImage(
                                     imageSrc: AppIcons.calendar
                                 ),
                                 CustomText(
                                   left: 4,
                                   text:  '12-Sept',
                                   fontSize: 10,
                                   fontWeight: FontWeight.w400,
                                   right: 4,
                                 ),
                               ],
                             ),
                               SizedBox(width: 8,),
                               Row(
                                 children: [
                                   CustomImage(
                                       imageSrc: AppIcons.clock,
                                     size: 12,
                                   ),
                                   CustomText(
                                     left: 4,
                                     text: '12:00 AM',
                                     textAlign: TextAlign.right,
                                     fontSize: 10,
                                     fontWeight: FontWeight.w400,
                                     right: 4,
                                   ),
                                 ],
                               )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                    ),
                        ),),
                  ),
                ),
              ],
            )
          );
        },),
      ),
    );
  }
}
