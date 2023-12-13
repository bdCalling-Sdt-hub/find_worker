import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class HomeCleanSection extends StatefulWidget {
  const HomeCleanSection({super.key});

  @override
  State<HomeCleanSection> createState() => _HomeCleanSectionState();
}

class _HomeCleanSectionState extends State<HomeCleanSection> {
  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(

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
    );
  }
}
