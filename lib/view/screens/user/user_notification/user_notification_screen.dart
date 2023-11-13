import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNotificationScreen extends StatefulWidget {
  const UserNotificationScreen({super.key});

  @override
  State<UserNotificationScreen> createState() => _UserNotificationScreenState();
}

class _UserNotificationScreenState extends State<UserNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(appBarContent:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.black_100,),
              ),
              CustomText(
               text: AppStrings.notification.tr,
               color: AppColors.blue_100,
               fontSize: 18,
               fontWeight: FontWeight.w500,
             ),
              const SizedBox()
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blue_60,width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Welcome to the Find Worker.',
                                bottom: 8,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: 'Fri,',
                                    fontSize: 12,
                                    color: AppColors.black_60,
                                  ),
                                  CustomText(
                                    text: '12 am',
                                    fontSize: 12,
                                    color: AppColors.black_60,
                                    left: 4,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blue_60,width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Welcome to the Find Worker.',
                                bottom: 8,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: 'Fri,',
                                    fontSize: 12,
                                    color: AppColors.black_60,
                                  ),
                                  CustomText(
                                    text: '12 am',
                                    fontSize: 12,
                                    color: AppColors.black_60,
                                    left: 4,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                );
              }),
    ));
  }
}
