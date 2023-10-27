import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/search/inner_widgtes/search_end_drawer.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        endDrawer: const Drawer(
          child: SearchEndDrawer(),
        ),
        key: scaffoldKey,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const CustomImage(
                          imageColor: AppColors.blue_100,
                          size: 20,
                          imageType: ImageType.svg,
                            imageSrc:AppIcons.chevronLeft
                        ),
                      ),
                     const SizedBox(width: 16),
                      const Expanded(
                        flex: 4,
                        child: CustomSearchField(hint: 'Search by categories'),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => scaffoldKey.currentState!.openEndDrawer(),
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.black_20, width: 1)
                          ),
                          child: SvgPicture.asset(

                              AppIcons.adjustments
                          ),
                        ),
                      )
                    ],
                  ),
                 const SizedBox(height: 32,),
                 const CustomText(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    text: 'Top Featured Services',
                  ),
                 const SizedBox(height:  16),
                  GridView.builder(
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
                        Container(
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
                          child: GestureDetector(
                            onTap: (){

                            },
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
                          bottom: 44,
                        ),
                      ],
                    );
                  },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
