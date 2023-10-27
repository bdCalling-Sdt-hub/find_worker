import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarWashSection extends StatefulWidget {
  const CarWashSection({super.key, required this.selectedIndex});
  final int selectedIndex;
  @override
  State<CarWashSection> createState() => _CarWashSectionState();
}

class _CarWashSectionState extends State<CarWashSection> {
  @override
  Widget build(BuildContext context) {
    print(widget.selectedIndex);
    return  SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: AppStrings.carWash,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoute.carWashDetailsScreen);
                },
                child:const CustomText(
                  color: AppColors.blue_100,
                  text: AppStrings.seeAll,
                  fontSize:14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 180
            ),
            itemCount: 20, itemBuilder: (BuildContext context, int index) {
            return Container(
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
            );
          },
          ),
        ],
      ),
    );
  }
}
