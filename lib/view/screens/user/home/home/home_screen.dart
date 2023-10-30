import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/home/home/home_screen_data/home_screen_data.dart';

import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'inner_widgets/car_wash_section.dart';


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
  int selectedIndex = -1;

  bool isCliked = false;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: false,
      bottom: false,
      child: DefaultTabController(
        length: category.length,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            title: const CustomText(
              color: AppColors.blue_100,
              text: AppStrings.logo,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ) ,
            actions:  [
              Padding(
                padding:const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.searchScreen);
                      },
                      child:const Icon(
                          Icons.search
                      ),
                    ),
                   const SizedBox(width: 16,),
                    GestureDetector(
                      onTap: (){},
                        child:const Icon(Icons.notifications_outlined))
                  ],
                ),
              )
            ],
            bottom: TabBar(
                physics: const BouncingScrollPhysics(),
                automaticIndicatorColorAdjustment: false,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                isScrollable: true,
                tabs: List.generate(category.length, (index) => SizedBox(
                  width: 70,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;
                        print(selectedIndex);
                        isCliked=true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 2, vertical: 2),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(
                              side: BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                            ),
                          ),
                          child: index == selectedIndex? Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(category[index]['image'].toString()))
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isCliked?AppColors.blue_60.withOpacity(0.5):AppColors.white.withOpacity(0)
                                ),
                              ),
                            ],
                          ) : Container(
                            margin: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(category[index]['image'].toString()))
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        CustomText(
                          maxLines: 1,
                          text: category[index]["text"].toString(),
                          bottom: 44,
                        ),
                      ],
                    ),
                  ),
                ))
            ),
            toolbarHeight: 150,
          ),
          body:LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return  SingleChildScrollView(
              padding:const EdgeInsets.only(left: 20,right: 20,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  selectedIndex == -1? const HomeScreenData() : selectedIndex == 0 ? CarWashSection(selectedIndex: selectedIndex, text: "Home Clean",)
                  : selectedIndex == 1 ? CarWashSection(selectedIndex: selectedIndex, text: "Car Wash",)  :
                  selectedIndex == 2 ? CarWashSection(selectedIndex: selectedIndex, text: "Air Condition") : const Text("Same way others data"),

                ],
              ),
            );
          },
          ),
        ),
      ),
    );
  }
}
