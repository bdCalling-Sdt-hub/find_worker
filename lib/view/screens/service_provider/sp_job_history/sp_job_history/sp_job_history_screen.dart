import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/Controller/sp_history_controller.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_history_job_details/sp_history_job_details_screen.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SpJobHistoryScreen extends StatefulWidget {
  const SpJobHistoryScreen({super.key});

  @override
  State<SpJobHistoryScreen> createState() => _SpJobHistoryScreenState();
}

class _SpJobHistoryScreenState extends State<SpJobHistoryScreen> {
  final _controller = Get.put(SpHistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const CustomText(
              color: AppColors.blue_100,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              text: AppStrings.jobHistory),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
              () => _controller.loading.value
                  ? const CustomLoader()
                  :  RefreshIndicator(
                          onRefresh: () async {
                            _controller.getHistoryList(false);
                          },
                          child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 20, vertical: 24),
                              child:_controller.historyList.isEmpty
                                  ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 250,),
                                    Image.asset(
                                      AppImages.empty,
                                      height: 80,
                                      width: 80,
                                    ),
                                    const Text("No Job History yet.")
                                  ],
                                ),
                              )
                                  : Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: AppColors.blue_100,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 16, bottom: 16),
                                    child: const CustomText(
                                      color: AppColors.white,
                                      textAlign: TextAlign.start,
                                      text: "Recent Jobs",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                      _controller.historyList.length,
                                      (index) {
                                        final demoData =
                                            _controller.historyList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(SpHistoryDetailsScreen(
                                              historyModel: demoData,
                                              index: index,
                                            ));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 14),
                                            decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFE7F0FD)),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text: _controller
                                                            .historyList[index]
                                                            .name!,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const CustomImage(
                                                                  imageSrc: AppIcons
                                                                      .calendar),
                                                              CustomText(
                                                                left: 4,
                                                                text: DateFormat(
                                                                        'dd MMM')
                                                                    .format(demoData
                                                                        .createAt!),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const CustomImage(
                                                                  imageSrc:
                                                                      AppIcons
                                                                          .clock),
                                                              CustomText(
                                                                left: 4,
                                                                text: DateFormat
                                                                        .jm()
                                                                    .format(demoData
                                                                        .createAt!),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4,
                                                        vertical: 4),
                                                    decoration: ShapeDecoration(
                                                      color: AppColors.green_10,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                    ),
                                                    child: CustomText(
                                                      color:
                                                          AppColors.green_100,
                                                      text: demoData.status!,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )),
                        ),
            );
          },
        ),
      ),
    );
  }
}
