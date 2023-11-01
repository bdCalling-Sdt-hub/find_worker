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

class HomeScreenData extends StatefulWidget {
  const HomeScreenData({super.key});

  @override
  State<HomeScreenData> createState() => _HomeScreenDataState();
}

class _HomeScreenDataState extends State<HomeScreenData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             CustomText(
              text:'Car Wash'.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoute.carWashDetailsScreen);
              },
              child: CustomText(
                color: AppColors.blue_100,
                text: 'See All'.tr,
                fontSize:14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),

        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(10, (index) =>  GestureDetector(
              onTap: (){
                Get.toNamed(AppRoute.userServiceDetailsScreen);
              },
              child: Container(
                margin:const EdgeInsets.only(right: 8),
                width: MediaQuery.of(context).size.width*.5,
                padding: const EdgeInsetsDirectional.symmetric(horizontal:8,vertical: 8 ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                              AppImages.carWah1
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Jhon doy",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        Row(
                          children: [
                            CustomImage(
                                imageType: ImageType.svg,
                                imageSrc: AppIcons.star),
                            CustomText(
                              text: "(4.5)",
                              right: 4,
                              left: 4,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(

                      children: [
                        CustomImage(
                            imageType: ImageType.svg,
                            imageSrc: AppIcons.location),
                        CustomText(
                          left: 4,
                          text: "Abu Dhabi",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          right: 4,
                        )

                      ],
                    )
                  ],
                ),
              ),
            ),),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             CustomText(
              text: 'Home Clean'.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            GestureDetector(
              onTap: (){},
              child: CustomText(
                color: AppColors.blue_100,
                text: 'See All'.tr,
                fontSize:14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(10, (index) =>  Container(
              margin:const EdgeInsets.only(right: 8),
              width: MediaQuery.of(context).size.width*.5,
              padding: const EdgeInsetsDirectional.symmetric(horizontal:8,vertical: 8 ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            AppImages.homeClean1
                        ),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Jhon doy",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      Row(
                        children: [
                          CustomImage(
                              imageType: ImageType.svg,
                              imageSrc: AppIcons.star),
                          CustomText(
                            text: "(4.5)",
                            left: 4,
                            right: 4,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(

                    children: [
                      CustomImage(
                          imageType: ImageType.svg,
                          imageSrc: AppIcons.location),
                      CustomText(
                        left: 4,
                        text: "Abu Dhabi",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        right: 4,
                      )

                    ],
                  )
                ],
              ),
            ),),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             CustomText(
              text: 'Air Condition Maintenance'.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            GestureDetector(
              onTap: (){},
              child: CustomText(
                color: AppColors.blue_100,
                text: 'See All'.tr,
                fontSize:14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(10, (index) =>  Container(
              margin:const EdgeInsets.only(right: 8),
              width: MediaQuery.of(context).size.width*.5,
              padding: const EdgeInsetsDirectional.symmetric(horizontal:8,vertical: 8 ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            AppImages.airCondition1
                        ),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Jhon dou",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      Row(
                        children: [
                          CustomImage(
                              imageType: ImageType.svg,
                              imageSrc: AppIcons.star),
                          CustomText(
                            text: "(4.5)",
                            left: 4,
                            right: 4,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(

                    children: [
                      CustomImage(
                          imageType: ImageType.svg,
                          imageSrc: AppIcons.location),
                      CustomText(
                        left: 4,
                        text: "Abu Dhabi",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        right: 4,
                      )

                    ],
                  )
                ],
              ),
            ),),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: GestureDetector(
            onTap: (){
              Get.toNamed(AppRoute.categoryScreen);
            },
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Didn’t see what you’re looking for?\nGo to'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Categories'.tr,
                    style: GoogleFonts.poppins(
                      color: AppColors.blue_100,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 100,)
      ],
    );
  }
}
