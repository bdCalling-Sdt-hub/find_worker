import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/category/Controller/category_controller.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../helper/Language/language_controller.dart';

class CategoryScreen extends StatefulWidget {
   CategoryScreen({super.key,required this.isBack});
  bool isBack;


  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  final _categoryController = Get.put(CategoryController());
  final _localizationController = Get.put(LocalizationController(sharedPreferences:Get.find()));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: widget.isBack?IconButton(onPressed:(){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios,size: 20.h,)
        ):SizedBox(),
        title: CustomText(
          fontWeight: FontWeight.w500,
            fontSize: 18,
            text:AppStrings.categories.tr,
            color: AppColors.blue_100,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return  Obx(()=>_categoryController.loading.value?const CustomLoader():
            MasonryGridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top:10.h,left: 10.w,right: 10.w),
              physics:const AlwaysScrollableScrollPhysics(),
              itemCount:_categoryController.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                final data= _categoryController.categoryList[index];
                return Container(
                  margin: EdgeInsets.only(bottom:16.h),
                  alignment: Alignment.center,
                  height: 130.h,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.carWashDetailsScreen,parameters:{
                        "cat_id":data.id!,
                        "cat_name":data.name!,
                        "cat_arabic":data.nameArabic??"",
                      });

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.h,
                          height: 80.h,
                          alignment: Alignment.center,
                          padding:  EdgeInsetsDirectional.symmetric(
                              horizontal: 2.w, vertical: 2.h),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF6AA4EE)),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsetsDirectional.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:NetworkImage(data.image!),fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          _localizationController.selectedIndex==0? data.name!:data.nameArabic!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize:14.h),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  ),
                );
              }, gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            ),
            );
          },
        ),
      ),
    );
  }
}
