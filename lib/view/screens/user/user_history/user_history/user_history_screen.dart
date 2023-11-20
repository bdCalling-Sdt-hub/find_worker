import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_history/Controller/user_history_controller.dart';
import 'package:find_worker/view/screens/user/user_history/user_history_details/user_history_details_screen.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../helper/SystemChromeHelper/system_chrome.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  final _controller = Get.put(UserHistoryController());
  @override
  void initState() {
    SystemChromeHelper.enableSystemChrome();
    _controller.getHistoryList(true);
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    SystemChromeHelper.blueColorSystemChrome();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 16,
                    color: AppColors.blue_100,
                  ),
                ),
                CustomText(
                  text: AppStrings.history.tr,
                  color: AppColors.blue_100,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox()
              ],
            ),
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return RefreshIndicator(
              onRefresh: () async {
                _controller.getHistoryList(false);
              },
              child: Obx(
                () => _controller.loading.value
                    ? const CustomLoader()
                    : _controller.historyList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.empty,
                                  height: 80,
                                  width: 80,
                                ),
                                const Text("No Hires here yet.")
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 20),
                            child: Column(
                              children: List.generate(
                                _controller.historyList.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(UserHistoryDetailsScreen(
                                      hireId:
                                          _controller.historyList[index].id!,
                                    ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.blue_100,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        //    const CustomImage(imageSrc: AppImages.hireListProfile,imageType: ImageType.png,size: 100,),
                                        CachedNetworkImage(
                                          imageUrl: _controller
                                              .historyList[index].image!,
                                          imageBuilder: (context, widget) {
                                            return Container(
                                              width: 155.w,
                                              height: 100.h,
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
                                              width: 155.w,
                                              height: 100.h,
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
                                              width: 155.w,
                                              height: 100.h,
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
                                                        .historyList[index]
                                                        .name!,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 4,
                                                      horizontal: 11),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.green_10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: CustomText(
                                                    text:
                                                        AppStrings.complete.tr,
                                                    fontSize: 12,
                                                    color: AppColors.green_100,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const CustomImage(
                                                  imageSrc: AppIcons.star,
                                                  size: 12,
                                                ),
                                                CustomText(
                                                  text:
                                                      '(${_controller.historyList[index].averageRating})',
                                                  fontSize: 10,
                                                  left: 4,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const CustomImage(
                                                  imageSrc: AppIcons.service,
                                                  imageColor:
                                                      AppColors.black_100,
                                                  size: 18,
                                                ),
                                                Flexible(
                                                  child: CustomText(
                                                    text: _controller
                                                        .historyList[index]
                                                        .serviceName!,
                                                    fontSize: 10,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    left: 8,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      const CustomImage(
                                                        imageSrc: AppIcons
                                                            .dateOfBirth,
                                                        imageColor:
                                                            AppColors.black_60,
                                                        size: 14,
                                                      ),
                                                      CustomText(
                                                        text: DateFormat(
                                                                'dd MMM')
                                                            .format(_controller
                                                                .historyList[
                                                                    index]
                                                                .createAt!),
                                                        fontSize: 10,
                                                        color:
                                                            AppColors.black_60,
                                                        left: 8,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const CustomImage(
                                                      imageSrc: AppIcons.clock,
                                                      imageColor:
                                                          AppColors.black_60,
                                                      size: 14,
                                                    ),
                                                    CustomText(
                                                      text: DateFormat.jm()
                                                          .format(_controller
                                                              .historyList[
                                                                  index]
                                                              .createAt!),
                                                      fontSize: 10,
                                                      color: AppColors.black_60,
                                                      left: 8,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
              ),
            );
          }),
        ));
  }
}
