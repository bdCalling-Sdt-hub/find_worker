import 'package:find_worker/model/hire_model.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_hire_list/Controller/hire_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_outline_button.dart';
import 'inner_widgets/cancel_hire_detais.dart';

class UserHireDetailsScreen extends StatefulWidget {
   UserHireDetailsScreen({super.key,required this.hireId});
  String hireId;
  @override
  State<UserHireDetailsScreen> createState() => _UserHireDetailsScreenState();
}

class _UserHireDetailsScreenState extends State<UserHireDetailsScreen> {

  final _controller = Get.put(HireController());

  @override
  void initState() {
    _controller.getHireDetails(widget.hireId);
    super.initState();
  }

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
              text: AppStrings.hireDetails.tr,
              color: AppColors.blue_100,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox()
          ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Obx(()=>_controller.hireLoading.value?const CustomLoader():
                   SingleChildScrollView(
                      padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image:DecorationImage(image: NetworkImage(_controller.hireDetails.value.image!),
                              fit: BoxFit.cover
                              )
                            ),
                          ),
                         const SizedBox(height: 16,),
                          Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Flexible(
                               child: Row(
                                 children: [
                                   Flexible(
                                     child: CustomText(
                                       text:_controller.hireDetails.value.name!,
                                       fontSize: 18,
                                       fontWeight: FontWeight.w500,
                                     ),
                                   ),
                                   SizedBox(width: 10.w,),
                                   Row(
                                     children: [
                                       const CustomImage(
                                         imageSrc: AppIcons.star,size: 12,
                                       ),
                                       CustomText(
                                         text: '(${_controller.hireDetails.value.averageRating})',
                                         fontWeight: FontWeight.w500,
                                         left: 4,
                                       ),
                                     ],
                                   ),
                                   
                                 ],
                               ),
                             ),
                             SizedBox(width: 10.w,),
                             InkWell(
                               onTap: (){
                                 _controller.launchPhoneDialer(_controller.hireDetails.value.contact!);
                               },
                               child: CircleAvatar(
                                 backgroundColor: AppColors.blue_100,
                                 radius: 20.r,
                                 child: Padding(
                                   padding: EdgeInsets.all(8.r),
                                   child: Icon(Icons.call,color: Colors.white,size:22.r,),
                                 ),
                               ),
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
                                  text: _controller.hireDetails.value.contact!,
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
                                text: _controller.hireDetails.value.address!,
                                fontWeight: FontWeight.w500,
                                left: 4,
                              ),
                            ],
                          ),

                          ///<--------------------- About Job--------------------->
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
                                    color:_controller
                                        .hireDetails.value
                                        .status ==
                                        AppConstants
                                            .canceled
                                        ? AppColors.red_10
                                        : _controller
                                        .hireDetails.value
                                        .status ==
                                        AppConstants
                                            .complete
                                        ? AppColors
                                        .green_10
                                        : _controller
                                        .hireDetails.value
                                        .status ==
                                        AppConstants
                                            .approved
                                        ? AppColors
                                        .blue_10
                                        : _controller.hireDetails.value.status ==
                                        AppConstants
                                            .working
                                        ? Colors
                                        .cyan
                                        .shade50
                                        : AppColors
                                        .yellow_10,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child:
                                   CustomText(
                                    text:_controller.hireDetails.value.status!,
                                    fontSize: 12,
                                    color: _controller
                                        .hireDetails.value
                                        .status ==
                                        AppConstants
                                            .canceled
                                        ? AppColors.red_100
                                        : _controller
                                        .hireDetails.value

                                        .status ==
                                        AppConstants
                                            .complete
                                        ? AppColors
                                        .green_100
                                        : _controller
                                        .hireDetails.value
                                        .status ==
                                        AppConstants
                                            .approved
                                        ? AppColors
                                        .blue_100
                                        : _controller.hireDetails.value.status ==
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
                          const SizedBox(height: 10,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: AppStrings.service.tr,
                              ),
                              CustomText(
                                text: _controller.hireDetails.value.serviceName!,
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
                                text: AppStrings.time.tr,
                              ),
                              CustomText(
                                text:DateFormat.jm().format(_controller.hireDetails.value.createAt!) ,
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
                                text: "${DateFormat.d('en_US').format(_controller.hireDetails.value.createAt!)} ${DateFormat.MMMM('en_US').format(_controller.hireDetails.value.createAt!)}",
                                fontWeight: FontWeight.w500,
                                left: 4,
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h,),
                          if(_controller.hireDetails.value.status==AppConstants.approved)
                            _approvedButton(context),

                          if(_controller.hireDetails.value.status==AppConstants.working)
                            workingButton(),
                           const SizedBox(height: 16,),

                        ],
                      )
                  ),
                );
              }),
        ));
  }

   workingButton() {
    return Column(
                            children: [

                              Obx(()=>
                                  CustomButton(onTap: () {
                                    _controller.completeService(_controller.hireDetails.value);
                                  },loading: _controller.completeLoading.value, text:AppStrings.complete.tr,),
                              ),
                              SizedBox(height: 16.h,),
                              CustomOutlineButton(onTap: () {
                                showDialog(context: context, builder: (_)=>HireDetailsCancelDialog());
                              }, text:AppStrings.cancel.tr,),



                            ],
                          );
  }
   _approvedButton(BuildContext context) {
    return Obx(()=>
        Column(
          children: [

            CustomButton(
                onTap: () {
                   _controller.startWorkService(_controller.hireDetails.value);
                },
               loading:_controller.startWorkLoading.value,
                text: AppStrings.startWork.tr),
            SizedBox(height: 15.h,),
            CustomOutlineButton(onTap: (){
              showDialog(context: context, builder: (_)=>HireDetailsCancelDialog());
            },
                text:AppStrings.cancel.tr)
          ],
        ),
    );
  }
}
