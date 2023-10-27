import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(appBarContent:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.blue_100,),
              ),
              const CustomText(
                text: AppStrings.history,
                color: AppColors.blue_100,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox()
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                    child: Column(
                      children:List.generate(3, (index) => GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoute.userHistoryDetailsScreen);
                        },
                        child: Container(
                          margin:const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.blue_100,width: 1),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            children: [
                              const CustomImage(imageSrc: AppImages.hireListProfile,imageType: ImageType.png,size: 100,),
                              const SizedBox(width: 16,),
                              Expanded(
                                  child:  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(
                                            text: 'John Doe',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 11),
                                            decoration: BoxDecoration(
                                                color: AppColors.green_10,
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: const CustomText(
                                              text: AppStrings.complete,
                                              fontSize: 12,
                                              color: AppColors.green_100,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      const Row(
                                        children: [
                                          CustomImage(imageSrc: AppIcons.star,size: 12,),
                                          CustomText(
                                            text: '(4.5)',
                                            fontSize: 10,
                                            left: 4,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      const Row(
                                        children: [
                                          CustomImage(imageSrc: AppIcons.service,imageColor: AppColors.black_100,size: 18,),
                                          CustomText(
                                            text: AppStrings.carWash,
                                            fontSize: 10,
                                            left: 8,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CustomImage(imageSrc: AppIcons.dateOfBirth,imageColor: AppColors.black_60,size: 14,),
                                              CustomText(
                                                text: '12-Sept',
                                                fontSize: 10,
                                                color: AppColors.black_60,
                                                left: 8,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              CustomImage(imageSrc: AppIcons.clock,imageColor: AppColors.black_60,size: 14,),
                                              CustomText(
                                                text: '12:00 AM',
                                                fontSize: 10,
                                                color: AppColors.black_60,
                                                left: 8,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ),) ,
                    )
                );
              }),
        ));
  }
}
