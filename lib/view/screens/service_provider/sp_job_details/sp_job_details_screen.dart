 import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_back.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/custom_outline_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../helper/AdMob/ad_display.dart';
import '../../../../model/hire_model.dart';
import '../../../widgets/custom_button.dart';
import 'controller/sp_job_details_controller.dart';
import 'inner_widgets/cancel_dialog.dart';
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
    interstitialAdd();
    super.initState();
  }

  interstitialAdd() {
    Future.delayed(Duration(seconds: 3), () {
      AdDsiplay().loadInterstitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("=====> Job id : ${widget.jobId}");
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.jobDetails.tr),
        leading:  CustomBack(),
      ),
      // appBar: CustomAppBar(
      //   appBarContent: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           Get.back();
      //         },
      //         child: const Icon(
      //           Icons.arrow_back_ios_new_outlined,
      //           size: 16,
      //           color: AppColors.blue_100,
      //         ),
      //       ),
      //       CustomText(
      //         text: AppStrings.jobDetails.tr,
      //         color: AppColors.blue_100,
      //         fontSize: 18,
      //         fontWeight: FontWeight.w500,
      //       ),
      //       const SizedBox()
      //     ],
      //   ),
      // ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(
          () => _controller.loading.value
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(()=>
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h,),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      _controller.jobDetails.value.image??""),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomText(
                          text: _controller.jobDetails.value.name!,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
                                  color: _controller.jobDetails.value.status==AppConstants.approved?const Color(0xFFE7F0FD) :_controller.jobDetails.value.status==AppConstants.working?Colors.cyan.shade50: AppColors.yellow_10,
                                  borderRadius: BorderRadius.circular(4)),
                              child: CustomText(
                                text: _controller.jobDetails.value.status!,
                                fontSize: 12,
                                color:_controller.jobDetails.value.status==AppConstants.approved?AppColors.blue_100:_controller.jobDetails.value.status==AppConstants.working?Colors.cyan.shade800:AppColors.yellow_100,
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
                            const CustomText(
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
                          _approvedButton(context),

                        if(_controller.jobDetails.value.status==AppConstants.working)
                          Column(
                            children: [
                              SizedBox(height: 30.h,),
                              Obx(()=>
                                 CustomButton(onTap: () {
                                  _controller.completeService(_controller.jobDetails.value);
                                },loading: _controller.completeLoading.value, text:AppStrings.complete.tr,),
                              ),
                              SizedBox(height: 16.h,),
                              CustomOutlineButton(onTap: () {
                                showDialog(context: context, builder: (_)=>SpJobDetailsCancelDialog());

                              }, text:AppStrings.cancel.tr,),



                            ],
                          )



                      ],
                    ),
                  )),
        );
      }),
    );
  }

  Obx _approvedButton(BuildContext context) {
    return Obx(()=>
                           Column(
                            children: [
                              SizedBox(height: 30.h,),
                              CustomButton(
                                  onTap: () {
                                    _controller.startWorkService(_controller.jobDetails.value);
                                  },
                                  loading:_controller.startWorkLoading.value,
                                  text: AppStrings.startWork.tr),
                                  SizedBox(height: 15.h,),
                              CustomOutlineButton(onTap: (){
                               showDialog(context: context, builder: (_)=>SpJobDetailsCancelDialog());
                              },
                                  text:AppStrings.cancel.tr)
                            ],
                          ),
                        );
  }

   _pendingButton() {
    return Obx(()=>
       Row(
        children: [
          Expanded(
              child:
                  CustomOutlineButton(onTap: () {
                    showDialog(context: context, builder: (_)=>SpJobDetailsCancelDialog());
                  },
                      text: AppStrings.cancel.tr)),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: CustomButton(onTap: () {
              _controller.acceptService(_controller.jobDetails.value);
            },
                loading: _controller.acceptWorkLoading.value,
                text: AppStrings.accept.tr),
          )
        ],
      ),
    );
  }
}
