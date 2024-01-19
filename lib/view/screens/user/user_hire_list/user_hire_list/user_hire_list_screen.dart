import 'package:cached_network_image/cached_network_image.dart';
import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_hire_list/Controller/hire_controller.dart';
import 'package:wrcontacts/view/screens/user/user_hire_list/user_hire_details/user_hire_details_screen.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserHireListScreen extends StatefulWidget {
  const UserHireListScreen({super.key});

  @override
  State<UserHireListScreen> createState() => _UserHireListScreenState();
}

class _UserHireListScreenState extends State<UserHireListScreen> {
  final _controller = Get.put(HireController());

  @override
  void initState() {
    _controller.getHireList(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStrings.hireList.tr),
      ),
      body: Obx(
        () => _controller.loading.value
            ? const CustomLoader()
            : _controller.hireList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.empty,
                          height: 80,
                          width: 80,
                        ),
                         Text("No hires here yet.".tr)
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      _controller.getHireList(false);
                    },
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left:20.w,right:20.w,bottom:88.h,top: 24.h),
                        child: Column(
                          children: List.generate(
                              _controller.hireList.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Get.to(UserHireDetailsScreen(
                                         hireId: _controller.hireList[index].id!,
                                      ));
                                      // Navigator.push(context, MaterialPageRoute(builder: (_)=> UserHireDetailsScreen(hireModel:_controller.hireList[index],index: index,)));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.blue_100,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: _controller
                                                .hireList[index].image!,
                                            imageBuilder: (context, widget) {
                                              return Container(
                                                width: 70,
                                                height: 83,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    image: DecorationImage(
                                                        image: widget,
                                                        fit: BoxFit.fill)),
                                              );
                                            },
                                            placeholder: (context, index) {
                                              return Container(
                                                width: 70,
                                                height: 83,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    color: Colors.grey),
                                              );
                                            },
                                            errorWidget:
                                                (context, value, widget) {
                                              return Container(
                                                width: 70,
                                                height: 83,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    color: Colors.grey),
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: CustomText(
                                                      text: _controller
                                                          .hireList[index]
                                                          .name!,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 4,
                                                        horizontal: 11),
                                                    decoration: BoxDecoration(
                                                        color: _controller
                                                                    .hireList[
                                                                        index]
                                                                    .status ==
                                                                AppConstants
                                                                    .canceled
                                                            ? AppColors.red_10
                                                            : _controller
                                                                        .hireList[
                                                                            index]
                                                                        .status ==
                                                                    AppConstants
                                                                        .complete
                                                                ? AppColors
                                                                    .green_10
                                                                : _controller
                                                                            .hireList[
                                                                                index]
                                                                            .status ==
                                                                        AppConstants
                                                                            .approved
                                                                    ? AppColors
                                                                        .blue_10
                                                                    : _controller.hireList[index].status ==
                                                                            AppConstants
                                                                                .working
                                                                        ? Colors
                                                                            .cyan
                                                                            .shade50
                                                                        : AppColors
                                                                            .yellow_10,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: CustomText(
                                                      text: _controller
                                                          .hireList[index]
                                                          .status!,
                                                      fontSize: 12,
                                                      color:
                                                      _controller
                                                          .hireList[
                                                      index]
                                                          .status ==
                                                          AppConstants
                                                              .canceled
                                                          ? AppColors.red_100
                                                          : _controller
                                                          .hireList[
                                                      index]
                                                          .status ==
                                                          AppConstants
                                                              .complete
                                                          ? AppColors
                                                          .green_100
                                                          : _controller
                                                          .hireList[
                                                      index]
                                                          .status ==
                                                          AppConstants
                                                              .approved
                                                          ? AppColors
                                                          .blue_100
                                                          : _controller.hireList[index].status ==
                                                          AppConstants
                                                              .working
                                                          ? Colors
                                                          .cyan
                                                          .shade800
                                                          : AppColors
                                                          .yellow_100,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const CustomImage(
                                                    imageSrc: AppIcons.star,
                                                    size: 12,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        '(${_controller.hireList[index].averageRating!})',
                                                    fontSize: 10,
                                                    left: 4,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: AppStrings.service.tr,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black_60,
                                                  ),
                                                  Flexible(
                                                    child: CustomText(
                                                      text: _controller
                                                          .hireList[index]
                                                          .serviceName!,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      );
                    }),
                  ),
      ),
    );
  }
}
