import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<Map<String,String>> category = [
    {
      'image': AppImages.cleanHome,
      'text':AppStrings.homeClean,
    },
    {
      'image': AppImages.carWash,
      'text':AppStrings.carWash,
    },
    {
      'image': AppImages.airCondition,
      'text':AppStrings.airConditionMaintenance,
    },
    {
      'image': AppImages.housekeeper,
      'text':"HouseKeeper",
    },
    {
      'image': AppImages.farmer,
      'text':AppStrings.farmer,
    },
    {
      'image': AppImages.pipeFitter,
      'text':AppStrings.pipeFitter,
    },
    {
      'image': AppImages.jensSalon,
      'text':AppStrings.jensSalon,
    },
    {
      'image': AppImages.homeMaintenance,
      'text':"Home Maintenance",
    },
    {
      'image': AppImages.manDriver,
      'text':AppStrings.manDriver ,
    },
    {
      'image': AppImages.womanDriver,
      'text':AppStrings.womanDriver,
    },
    {
      'image': AppImages.ladiesSalon,
      'text':AppStrings.ladiesSalon,
    },
    {
      'image': AppImages.privateTutor,
      'text':AppStrings.privateTutor,
    },
    {
      'image': AppImages.butcher,
      'text':AppStrings.butcher,
    },
    {
      'image': AppImages.homeBusiness,
      'text':AppStrings.homeBusiness,
    },
    {
      'image': AppImages.moverService,
      'text':"Mover Service",
    },
    {
      'image': AppImages.henna,
      'text':"Henna Service",
    },
    {
      'image': AppImages.homePainter,
      'text':"Home Painter",
    },
    {
      'image': AppImages.catering,
      'text':AppStrings.catering,
    },
    {
      'image': AppImages.cableFixing,
      'text':AppStrings.cableFixing,
    },
    {
      'image': AppImages.gypsumBoardFloor,
      'text':AppStrings.gypsumBoardFloor,
    },
    {
      'image': AppImages.carTiersRepair,
      'text':AppStrings.carTiresRepair,
    },
    {
      'image': AppImages.carRecovery,
      'text':AppStrings.carRecovery,
    },

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:const CustomText(
            fontWeight: FontWeight.w500,
              fontSize: 18,
              text:AppStrings.category,
              color: AppColors.blue_100,
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return  SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 152
                ),
                itemCount: category.length, itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.carWashDetailsScreen);
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 2),
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(category[index]['image'].toString()))
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    CustomText(
                      maxLines: 1,
                      text: category[index]["text"].toString(),
                      bottom: 42,
                    ),
                  ],
                );
              },
              ),
            );
          },
        ),
      ),
    );
  }
}
