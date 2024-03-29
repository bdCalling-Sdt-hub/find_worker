import 'package:wocontacts/helper/Language/language_controller.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_constents.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/custom_back.dart';
import 'package:wocontacts/view/widgets/custom_loader.dart';
import 'package:wocontacts/view/widgets/custom_outline_button.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/custom_button.dart';
import '../Controller/sp_history_controller.dart';
import '../Controller/sp_history_details_controller.dart';
import 'inner_widgtes/sp_history_details_alert.dart';




class SpJobHistoryDetailsScreen extends StatefulWidget {
  SpJobHistoryDetailsScreen({
    super.key,
    required this.jobId,
  });
  String jobId;

  @override
  State<SpJobHistoryDetailsScreen> createState() => _SpJobDetailsScreenState();
}

class _SpJobDetailsScreenState extends State<SpJobHistoryDetailsScreen> {
  final _controller = Get.put(SpHistoryController());
  final _localizationController = Get.find<LocalizationController>();

  @override
  void initState() {
    _controller.getJobHistoryDetails(widget.jobId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.jobDetails.tr),
        leading:  CustomBack(),
        actions: [
          IconButton(onPressed:(){
            showDialog(context: context, builder: (_)=>SpHistoryDetailsAlert(id: widget.jobId,));


          },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent
        , icon:const CustomImage(imageSrc:AppIcons.trash),),
          SizedBox(width:10.w,)
        ],
      ),

      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
                  () => _controller.getJobHistoryDetailsLoading.value
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
                                        _controller.jobDetails.value.image!),
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
                               CustomText(
                                text: 'Contact'.tr,
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
                                padding:  const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 11),
                                decoration: BoxDecoration(
                                    color:_controller.jobDetails.value.status==AppConstants.canceled?AppColors.red_10 :AppColors.green_10,
                                    borderRadius: BorderRadius.circular(4)),
                                child: CustomText(
                                  text: _controller.jobDetails.value.status!,
                                  fontSize: 12,
                                  color:_controller.jobDetails.value.status==AppConstants.canceled?AppColors.red_100 :AppColors.green_100,
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
                                text: _localizationController.selectIndex==0? _controller.jobDetails.value.serviceName!:_controller.jobDetails.value.serviceNameArabic!,
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
                                text: AppStrings.time.tr,
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






                        ],
                      ),
                  )),
            );
          }),
    );
  }



}
