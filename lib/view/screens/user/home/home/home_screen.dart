import 'package:cached_network_image/cached_network_image.dart';
import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/user/category/category_screen.dart';
import 'package:wocontacts/view/screens/user/home/Controller/home_controller.dart';
import 'package:wocontacts/view/screens/user/user_profile/Controller/profile_controller.dart';
import 'package:wocontacts/view/widgets/custom_loader.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../helper/Language/language_controller.dart';
import '../../../../widgets/image/custom_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(UserHomeController());

  final _localizationController =
      Get.put(LocalizationController(sharedPreferences: Get.find()));

  final _profileController = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          // title: _profileController.userData.value.imageSrc==null||_profileController.userData.value.imageSrc==""? Container(
          //   height: 45,
          //   width: 45,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(
          //           color: Colors.grey.shade200,
          //           width: 0.5
          //       ),
          //       image: const DecorationImage(
          //           image:AssetImage(AppIcons.unSplashProfileImage),fit: BoxFit.fill)
          //        ),
          //
          //
          // ):Container(
          //   height: 45,
          //   width: 45,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(
          //         color: Colors.grey.shade200,
          //         width: 0.5
          //       ),
          //       image: DecorationImage(
          //           image:NetworkImage(_profileController.userData.value.imageSrc??""),fit: BoxFit.fill)),
          // ),
          // title: CustomText(
          //   color: AppColors.blue_100,
          //   text: AppStrings.logo.tr,
          //   fontSize: 18.sp,
          //   fontWeight: FontWeight.w500,
          // ),
          //title:const CustomImage(imageSrc:AppIcons.appLogo,imageType: ImageType.svg,),
          // leading:Image.asset(AppIcons.appLogo,height:35,width: 22,),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.searchScreen);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.userNotificationScreen);
                      },
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF333333),
                      ))
                ],
              ),
            ),
          ]),
      body: Obx(
        () => _homeController.loading.value
            ? const CustomLoader()
            : RefreshIndicator(
                onRefresh: () async {
                  await _homeController.getData(false);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      _categoryWidget(),

                      /// <----------------- All Service List --------------------->
                      CustomText(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        left: 20,
                        bottom: 16.h,
                        text: AppStrings.newServices.tr,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 200),
                        itemCount: _homeController.allServiceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var demoData = _homeController.allServiceList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.userServiceDetailsScreen,
                                  arguments: demoData);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .5,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFF6AA4EE)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: demoData.image!,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                            baseColor: Colors.grey.shade700,
                                            highlightColor:
                                                Colors.grey.shade400,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            )),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          color: Colors.grey.withOpacity(0.6)),
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CustomText(
                                          text: demoData.providerName!,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(width:10.w,),
                                      Row(
                                        children: [
                                          const CustomImage(
                                              imageType: ImageType.svg,
                                              imageSrc: AppIcons.star),
                                          CustomText(
                                            text:
                                                "(${demoData.averageRating.toString()})",
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height:4,
                                  ),
                                  Text( _localizationController.selectedIndex == 0?demoData.serviceName??"":demoData.serviceNameArabic??"",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey
                                  ),),
                                  const SizedBox(
                                    height:4,
                                  ),
                                  Row(
                                    children: [
                                      const CustomImage(
                                          imageType: ImageType.svg,
                                          imageSrc: AppIcons.location),
                                      Flexible(
                                        child: CustomText(
                                          left: 4,
                                          text: demoData.location!,
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

                      //_carWash(),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // _homeClean(),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // _airConditionMaintenance(),
                      // SizedBox(
                      //   height: 20.h,
                      // ),

                      // RichText(
                      //     textAlign: TextAlign.center,
                      //     text: TextSpan(
                      //         text: AppStrings.didNotSeeWhat.tr,
                      //         style: TextStyle(
                      //             fontSize: 14.sp,
                      //             color: const Color(0xFF333333)),
                      //         children: [
                      //           TextSpan(
                      //             text: "\n${AppStrings.goto.tr} ",
                      //             recognizer: TapGestureRecognizer()
                      //               ..onTap = () {
                      //                 Get.to(CategoryScreen(
                      //                   isBack: true,
                      //                 ));
                      //               },
                      //             style: TextStyle(
                      //                 fontSize: 14.sp,
                      //                 color: const Color(0xFF333333)),
                      //           ),
                      //           TextSpan(
                      //             text: AppStrings.categories.tr,
                      //             recognizer: TapGestureRecognizer()
                      //               ..onTap = () {
                      //                 Get.to(CategoryScreen(
                      //                   isBack: true,
                      //                 ));
                      //               },
                      //             style: TextStyle(
                      //                 fontSize: 18.sp,
                      //                 fontWeight: FontWeight.w500,
                      //                 color: const Color(0xFF0668E3)),
                      //           ),
                      //         ])),
                      // SizedBox(
                      //   height: 16,
                      // ),

                      SizedBox(
                        height: 200.h,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _carWash() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.carWash.tr,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.carWashDetailsScreen, parameters: {
                    "cat_id": "VBhuTZnI7ec0Bvy5IYIm",
                    "cat_name": "Car Wash"
                  });
                },
                child: CustomText(
                  color: AppColors.blue_100,
                  text: AppStrings.seeAll.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 180),
            itemCount: _homeController.carWashList.length > 2
                ? 2
                : _homeController.carWashList.length,
            itemBuilder: (BuildContext context, int index) {
              var demoData = _homeController.carWashList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.userServiceDetailsScreen,
                      arguments: demoData);
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
                        imageUrl: demoData.image!,
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
                              text: demoData.providerName!,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            children: [
                              const CustomImage(
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
                              text: demoData.location!,
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

  _homeClean() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.homeClean.tr,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.carWashDetailsScreen, parameters: {
                    "cat_id": "exKagBPgKKUVQ8QyYrO7",
                    "cat_name": "Home Clean"
                  });
                },
                child: CustomText(
                  color: AppColors.blue_100,
                  text: AppStrings.seeAll.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 180),
            itemCount: _homeController.homeCleanList.length > 2
                ? 2
                : _homeController.homeCleanList.length,
            itemBuilder: (BuildContext context, int index) {
              var demoData = _homeController.homeCleanList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.userServiceDetailsScreen,
                      arguments: demoData);
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
                        imageUrl: demoData.image!,
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
                              text: demoData.providerName!,
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
                              text: demoData.location!,
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

  _airConditionMaintenance() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.airConditionMaintenance.tr,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.carWashDetailsScreen, parameters: {
                    "cat_id": "b0yWTYORILumrLmVpxrt",
                    "cat_name": "Air Condition Maintenance"
                  });
                },
                child: CustomText(
                  color: AppColors.blue_100,
                  text: AppStrings.seeAll.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 180),
            itemCount: _homeController.airConditionList.length > 2
                ? 2
                : _homeController.airConditionList.length,
            itemBuilder: (BuildContext context, int index) {
              var demoData = _homeController.airConditionList[index];

              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.userServiceDetailsScreen,
                      arguments: demoData);
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
                        imageUrl: demoData.image!,
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
                              text: demoData.providerName!,
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
                              text: demoData.location!,
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

  _categoryWidget() {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          itemBuilder: (context, index) {
            var data = _homeController.categoryList[index];
            return SizedBox(
              width: 66.w,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.carWashDetailsScreen, parameters: {
                    "cat_id": data.id!,
                    "cat_name": data.name!,
                    "cat_arabic": data.nameArabic!,
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.h,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF6AA4EE), width: 1),
                          color: Colors.white),
                      child: Image.network(
                        data.image!,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      _localizationController.selectedIndex == 0
                          ? data.name!
                          : data.nameArabic!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 14.w,
            );
          },
          itemCount: _homeController.categoryList.length),
    );
  }
}
