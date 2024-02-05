import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/user/search/Controller/search_controller.dart';
import 'package:wocontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../helper/Language/language_controller.dart';

class SearchEndDrawer extends StatefulWidget {

  const SearchEndDrawer({super.key});

  @override
  State<SearchEndDrawer> createState() => _SearchEndDrawerState();
}

class _SearchEndDrawerState extends State<SearchEndDrawer> {

  int selectIndex= -1;

  final _searchController = Get.put(SearchAndFilterController());
  final _localizationController = Get.put(LocalizationController(sharedPreferences:Get.find()));




  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFF818181)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter'.tr,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child:  const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.blue_100,
                  size: 24,
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category'.tr,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1, width: MediaQuery.of(context).size.width,
                    color: AppColors.blue_20,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    children:List.generate(_searchController.categoryList.length, (index) => GestureDetector(
                      onTap: (){
                        if(selectIndex==index){
                          setState(() {
                            selectIndex=(-1);
                          });
                        }else{
                          setState(() {
                            selectIndex=index;
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(4.h),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: ShapeDecoration(
                          color: index == selectIndex ? AppColors.blue_100 : AppColors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: index == selectIndex ? AppColors.blue_100 :  AppColors.blue_100 ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          _localizationController.selectedIndex==0? _searchController.categoryList[index].name!: _searchController.categoryList[index].nameArabic!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            color: index == selectIndex ? AppColors.white : AppColors.blue_100,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ) ),
                  ),







                ],
              ),
            ),
          ),
          BottomNavButton(
            buttonText: AppStrings.apply.tr,
            onTap: () {
              if(selectIndex==(-1)){
                Get.back();
              }else{
                _searchController.focusNode.unfocus();
                _searchController.typeAheadController.text= _localizationController.selectedIndex==0? _searchController.categoryList[selectIndex].name!: _searchController.categoryList[selectIndex].nameArabic!;
                _searchController.getSortedServicesByCategory(_searchController.categoryList[selectIndex].id!);
                Get.back();
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
          SizedBox(height: 54.h,)
        ],
      ),
    );
  }
}
