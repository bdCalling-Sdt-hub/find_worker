import 'package:cached_network_image/cached_network_image.dart';
import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/search/Controller/search_controller.dart';
import 'package:wrcontacts/view/screens/user/search/inner_widgtes/search_end_drawer.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:wrcontacts/view/widgets/text_field/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = Get.put(SearchAndFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(
        backgroundColor: Colors.transparent,
        child: SearchEndDrawer(),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(()=>_searchController.loading.value?const CustomLoader():
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20.w,),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const CustomImage(
                            imageColor: AppColors.blue_100,
                            size: 20,
                            imageType: ImageType.svg,
                            imageSrc: AppIcons.chevronLeft),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 4,
                        child: TypeAheadFormField(

                          textFieldConfiguration: TextFieldConfiguration(
                            onChanged: (v){
                              if(v.isEmpty){
                                _searchController.isSearch(-1);
                              }
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "Search by categories",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 15.h),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 45.w),
                                prefixIcon: SvgPicture.asset(
                                  AppIcons.search,
                                  color: const Color(0xFFA7A7A7),
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                hintStyle: GoogleFonts.montserrat(
                                  color: AppColors.black_40,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE7F0FD), width: 1)),
                                disabledBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE7F0FD), width: 1)),
                                errorBorder: InputBorder.none),
                            controller: _searchController.typeAheadController,
                          ),

                          suggestionsCallback: (pattern) =>
                              _searchController.getSuggestions(pattern),
                          itemBuilder: (context, suggestion) => ListTile(
                            title: Text(suggestion.name!),
                            dense: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12.w),
                            visualDensity: const VisualDensity(vertical: -3),
                            //   leading:Image.network(),
                          ),
                          itemSeparatorBuilder: (context, index) =>
                              const Divider(
                            height: 0.2,
                          ),
                          transitionBuilder:
                              (context, suggestionsBox, controller) =>
                                  suggestionsBox,
                          onSuggestionSelected: (suggestion) {
                            _searchController.typeAheadController.text =
                                suggestion.name!;
                            _searchController.selectCategory.value=suggestion.id!;
                            _searchController.getSortedServicesByCategory(suggestion.id!);
                                  debugPrint("Select category ${suggestion.id}");
                          },
                          suggestionsBoxController:
                              _searchController.suggestionBoxController,
                          onSaved: (value) {
                            debugPrint("Save data ${value}");
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => scaffoldKey.currentState!.openEndDrawer(),
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 15, vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color:const Color(0xFFE7F0FD), width: 1)),
                          child: SvgPicture.asset(AppIcons.adjustments),
                        ),
                      ),
                      SizedBox(width: 20.w,),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Expanded(
                    child:
                       Obx(()=>_searchController.isSearch.value==(-1)?_toFeaturedServices():_searchController.serviceLoading.value?const Center(child: CustomLoader()):_searchController.servicesList.isEmpty? Center(child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Image.asset(AppImages.empty,height: 100,width: 100,),
                           const SizedBox(height: 10),
                           Text(AppStrings.noDataAvailable.tr)
                         ],
                       ),
                           ): _serviceData()),

                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _serviceData(){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          const CustomText(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            text: 'Top Featured Services',
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
           padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 180
            ),
            itemCount:_searchController.servicesList.length, itemBuilder: (BuildContext context, int index) {
            var demoData= _searchController.servicesList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.userServiceDetailsScreen,arguments:demoData);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 8, vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                    const BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl:demoData.image!,
                      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          )),
                      errorWidget: (context, url, error) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            color: Colors.grey.withOpacity(0.6)),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),

                            color: Colors.grey,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: demoData.serviceName!,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            CustomImage(
                                imageType: ImageType.svg,
                                imageSrc: AppIcons.star),
                            CustomText(
                              text: "(${demoData.averageRating.toString()})",
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const CustomImage(
                            imageType: ImageType.svg,
                            imageSrc: AppIcons.location),
                        Flexible(
                          child: CustomText(
                            left: 4,
                            text:demoData.location!,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          ),
        ],
      ),
    );
  }



  _toFeaturedServices() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const CustomText(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          text: 'Top Featured Services',
                        ),
                         SizedBox(height: 16.h),
                        MasonryGridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _searchController.categoryList.length>4?4:_searchController.categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data= _searchController.categoryList[index];
                            return Container(
                              margin: EdgeInsets.only(bottom:16.h),
                              alignment: Alignment.center,
                              height: 130.h,
                              child: GestureDetector(
                                onTap: (){
                                  _searchController.typeAheadController.text =
                                  data.name!;
                                  _searchController.selectCategory.value=data.id!;
                                  _searchController.getSortedServicesByCategory(data.id!);
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
                                       data.name!,
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
                      ],
                    ),
    );
  }
}
