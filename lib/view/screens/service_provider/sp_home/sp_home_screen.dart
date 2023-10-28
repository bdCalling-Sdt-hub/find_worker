import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/advanced_switch/advanced_switch.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpHomeScreen extends StatefulWidget {
  const SpHomeScreen({super.key});

  @override
  State<SpHomeScreen> createState() => _SpHomeScreenState();
}

class _SpHomeScreenState extends State<SpHomeScreen> {
  final _controller = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(appBarContent:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: AppStrings.logo,
                color: AppColors.blue_100,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              AdvancedSwitch(
                controller: _controller,
                activeColor: AppColors.blue_60.withOpacity(.5),
                inactiveColor: AppColors.black_60.withOpacity(.5),
                activeChild: const CustomText(
                  text: 'Online',
                  color: AppColors.blue_100,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                inactiveChild: const CustomText(
                  text: 'Offline',
                  color: AppColors.black_60,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                width: 100,
                height: 30.0,
                enabled: true,
                disabledOpacity: 0.5,
              ),
              const CustomImage(imageSrc:AppIcons.bell,size: 24,)
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.blue_100,width: 1),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF3F3F3),Color(0xFFCCE0FA),],
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1,color: AppColors.blue_100),
                                  image: const DecorationImage(image: AssetImage('assets/images/profile_smith.png'))
                                ),
                              ),
                              const SizedBox(width: 16,),
                              const Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'John Doe',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Row(
                                        children: [
                                          CustomImage(
                                            imageSrc: AppIcons.star,size: 12,
                                          ),
                                          CustomText(
                                            text: '(4.5)',
                                            fontWeight: FontWeight.w500,
                                            left: 4,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: AppStrings.service,
                                        color: AppColors.black_60,
                                      ),
                                      CustomText(
                                        text: AppStrings.carWash,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.blue_100,width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: AppStrings.aboutJob,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                bottom: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: AppStrings.status,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 11),
                                    decoration: BoxDecoration(
                                        color: AppColors.yellow_10,
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: const CustomText(
                                      text: AppStrings.pending,
                                      fontSize: 12,
                                      color: AppColors.yellow_100,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: AppStrings.service,
                                  ),
                                  CustomText(
                                    text: AppStrings.carWash,
                                    fontWeight: FontWeight.w500,
                                    left: 4,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: AppStrings.time,
                                  ),
                                  CustomText(
                                    text: '12:00 am',
                                    fontWeight: FontWeight.w500,
                                    left: 4,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: AppStrings.date,
                                  ),
                                  CustomText(
                                    text: '12 September',
                                    fontWeight: FontWeight.w500,
                                    left: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                );
              }),
        ));
  }
}