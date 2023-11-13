import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/hire_model.dart';
import '../../../widgets/custom_button.dart';
import 'inner_widgets/sp_job_details_alert.dart';

class SpJobDetailsScreen extends StatefulWidget {
  SpJobDetailsScreen({super.key,required this.hireModel,required this.index});
  HireModel hireModel;
  int index;

  @override
  State<SpJobDetailsScreen> createState() => _SpJobDetailsScreenState();
}

class _SpJobDetailsScreenState extends State<SpJobDetailsScreen> {
  final _controller = Get.put(SpHomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(appBarContent:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.blue_100,),
              ),
               CustomText(
                text: AppStrings.jobDetails.tr,
                color: AppColors.blue_100,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox()
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    padding:const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image:DecorationImage(image: NetworkImage(widget.hireModel.image!),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: CustomText(
                                text:widget.hireModel.name!,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                const CustomImage(
                                  imageSrc: AppIcons.star,size: 12,
                                ),
                                CustomText(
                                  text: '(${widget.hireModel.averageRating})',
                                  fontWeight: FontWeight.w500,
                                  left: 4,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Contact',
                            ),
                            Flexible(
                              child: CustomText(
                                text: widget.hireModel.contact!,
                                fontWeight: FontWeight.w500,
                                left: 4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             CustomText(
                              text: AppStrings.address.tr,
                            ),
                            CustomText(
                              text: widget.hireModel.address!,
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16,bottom: 16),
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
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 11),
                              decoration: BoxDecoration(
                                  color: AppColors.yellow_10,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child:
                              CustomText(
                                text:widget.hireModel.status!,
                                fontSize: 12,
                                color: AppColors.yellow_100,
                              ),

                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.service.tr,
                            ),
                            CustomText(
                              text: widget.hireModel.serviceName!,
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.time,
                            ),
                            CustomText(
                              text:DateFormat.jm().format(widget.hireModel.createAt!) ,
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             CustomText(
                              text: AppStrings.date.tr,
                            ),
                            CustomText(
                              text: "${DateFormat.d().format(widget.hireModel.createAt!)} ${DateFormat.MMMM().format(widget.hireModel.createAt!)}",
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        if(widget.hireModel.status=="Pending")
                          const SizedBox(height: 72,),
                        if(widget.hireModel.status=="Pending")
                          Obx(()=>
                              CustomButton(onTap: () {
                                _controller.completeService(widget.hireModel,);
                              }, text:AppStrings.complete.tr,
                                loading: _controller.completeLoading.value,
                                color: const Color(0xFF2BA24C),
                              ),
                          ),

                        // CustomButton(
                        //   buttonWidth: MediaQuery.of(context).size.width,
                        //   onPressed: () {
                        //    _controller.completeService(widget.hireModel,widget.index);
                        //   },
                        //   titleText: AppStrings.complete,
                        //   titleColor: AppColors.white,
                        //   buttonBgColor: AppColors.green_100,
                        //   titleSize: 18,
                        //   titleWeight: FontWeight.w600,
                        // ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(text: 'Click on the ',style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xff5A5A5A),
                              )),
                              TextSpan(text: '“Complete”', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: Color(0xff5A5A5A),)),
                              TextSpan(text: 'button after getting your current service to complete the service status.',style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xff5A5A5A),
                              )),
                            ],
                          ),
                        ),
                      ],
                    )
                );
              }),
        ));
  }
}
