import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/custom_outline_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/hire_model.dart';
import '../../../widgets/custom_button.dart';
import 'controller/sp_job_details_controller.dart';
import 'inner_widgets/sp_job_details_alert.dart';

class SpJobDetailsScreen extends StatefulWidget {
  SpJobDetailsScreen({
    super.key,
    required this.jobId,
  });
  String jobId;

  @override
  State<SpJobDetailsScreen> createState() => _SpJobDetailsScreenState();
}

class _SpJobDetailsScreenState extends State<SpJobDetailsScreen> {
  final _controller = Get.put(SpJobDetailsController());

  @override
  void initState() {
    _controller.getJobHistory(widget.jobId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: AppStrings.jobDetails.tr,
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
        return Obx(
          () => _controller.loading.value
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(
                                    _controller.jobDetails.value.image!),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: _controller.jobDetails.value.name!,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              const CustomImage(
                                imageSrc: AppIcons.star,
                                size: 12,
                              ),
                              CustomText(
                                text:
                                    '(${_controller.jobDetails.value.averageRating})',
                                fontWeight: FontWeight.w500,
                                left: 4,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Contact',
                          ),
                          Flexible(
                            child: CustomText(
                              text: _controller.jobDetails.value.contact!,
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.address.tr,
                          ),
                          CustomText(
                            text: _controller.jobDetails.value.address!,
                            fontWeight: FontWeight.w500,
                            left: 4,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        height: 1,
                        color: AppColors.blue_20,
                      ),
                      CustomText(
                        text: AppStrings.aboutJob.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        bottom: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.status.tr,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 11),
                            decoration: BoxDecoration(
                                color: AppColors.yellow_10,
                                borderRadius: BorderRadius.circular(4)),
                            child: CustomText(
                              text: _controller.jobDetails.value.status!,
                              fontSize: 12,
                              color: AppColors.yellow_100,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.service.tr,
                          ),
                          CustomText(
                            text: _controller.jobDetails.value.serviceName!,
                            fontWeight: FontWeight.w500,
                            left: 4,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.time,
                          ),
                          CustomText(
                            text: DateFormat.jm()
                                .format(_controller.jobDetails.value.createAt!),
                            fontWeight: FontWeight.w500,
                            left: 4,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.date.tr,
                          ),
                          CustomText(
                            text:
                                "${DateFormat.d().format(_controller.jobDetails.value.createAt!)} ${DateFormat.MMMM().format(_controller.jobDetails.value.createAt!)}",
                            fontWeight: FontWeight.w500,
                            left: 4,
                          ),
                        ],
                      ),
                      if (_controller.jobDetails.value.status ==
                          AppConstants.pending)
                        SizedBox(
                          height: 74.h,
                        ),
                      if (_controller.jobDetails.value.status ==
                          AppConstants.pending)
                        _pendingButton(),
                      if (_controller.jobDetails.value.status ==
                          AppConstants.approved)
                        Column(
                          children: [
                            SizedBox(height: 30.h,),
                            CustomButton(
                                onTap: () {}, text: AppStrings.startWork.tr),
                                SizedBox(height: 15.h,),
                            CustomOutlineButton(onTap: (){}, text:AppStrings.cancel.tr)
                          ],
                        ),
                      
                    ],
                  )),
        );
      }),
    );
  }

  Row _pendingButton() {
    return Row(
      children: [
        Expanded(
            child:
                CustomOutlineButton(onTap: () {}, text: AppStrings.cancel.tr)),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: CustomButton(onTap: () {}, text: AppStrings.accept.tr),
        )
      ],
    );
  }
}
