import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_images.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Binding/user_bottom_binding.dart';

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
              text: AppStrings.carWash.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoute.carWashDetailsScreen);
              },
              child: CustomText(
                color: AppColors.blue_100,
                text: AppStrings.seeAll.tr,
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
                          text: "Jubayed",
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
              text: AppStrings.homeClean.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            GestureDetector(
              onTap: (){},
              child: CustomText(
                color: AppColors.blue_100,
                text: AppStrings.seeAll.tr,
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
                        text: "Jubayed",
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
              text: AppStrings.airConditionMaintenance.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            GestureDetector(
              onTap: (){},
              child: CustomText(
                color: AppColors.blue_100,
                text: AppStrings.seeAll.tr,
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
                        text: "Jubayed",
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
              Get.to(UserBottomNavBarScreen(currentIndex: 1),binding:UserBottomNavBinding());
            },
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Didn’t see what you’re looking for?\nGo to ',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Categories',
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
        )
      ],
    );
  }
}
