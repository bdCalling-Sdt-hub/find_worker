import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return  SafeArea(
      top: false,
      bottom: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar:AppBar(
            title:const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  color: AppColors.blue_100,
                  text: AppStrings.logo,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 16,),
                    Icon(Icons.notifications_outlined)
                  ],
                )

              ],) ,

          ),
          body:LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              controller: ScrollController(),
              child: DefaultTabController(
                length: category.length,
                child: TabBar(
                  automaticIndicatorColorAdjustment: false,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  tabs: List.generate(category.length, (index) => SizedBox(
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                        width: 60,
                       height: 60,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(
                              side: BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                            ),
                          ),
                          child: Container(

                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppColors.blue_60.withOpacity(0.6),
                                shape: BoxShape.circle
                            ),
                            child: CustomImage(
                                size: 30,
                                imageType: ImageType.png,
                                imageSrc: category[index]['image'].toString()),
                          ),

                        ),
                        const SizedBox(height: 8,),
                        CustomText(
                          maxLines: 1,
                          text: category[index]["text"].toString(),
                        )

                      ],
                    ),
                  ))
                ),
              ) ,
            );
          },),
        ),

      ),
    );
  }
}
