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

class CarWashDetailsScreen extends StatefulWidget {
  const CarWashDetailsScreen({super.key});

  @override
  State<CarWashDetailsScreen> createState() => _CarWashDetailsScreenState();
}

class _CarWashDetailsScreenState extends State<CarWashDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap:(){
                  Get.back();
                },
                child:  const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 18,
                  color: AppColors.blue_100,
                ),
              ),
              const CustomText(
                text: AppStrings.carWash,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.blue_100,
              ),
              const SizedBox()
            ],
          )),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return  SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 24,horizontal: 20),
          physics:const BouncingScrollPhysics(),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 180
            ),
            itemCount: 20, itemBuilder: (BuildContext context, int index) {
           return GestureDetector(
             onTap: (){
               Get.toNamed(AppRoute.userServiceDetailsScreen);
             },
             child: Container(
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
              ),
           );
          },
          ),
        );
      },),
    );
  }
}
