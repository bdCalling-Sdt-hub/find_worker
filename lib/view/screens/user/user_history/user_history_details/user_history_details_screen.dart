import 'package:cached_network_image/cached_network_image.dart';
import 'package:wrcontacts/model/hire_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_history/user_history_details/inner_widgets/user_history_details_alert.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_back.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../Controller/user_history_controller.dart';

class UserHistoryDetailsScreen extends StatefulWidget {
   const UserHistoryDetailsScreen({super.key,required this.hireId});

  final String hireId;


  @override
  State<UserHistoryDetailsScreen> createState() => _UserHistoryDetailsScreenState();
}

class _UserHistoryDetailsScreenState extends State<UserHistoryDetailsScreen> {

  final _controller=Get.put(UserHistoryController());

@override
  void initState() {
    _controller.getHireDetails(widget.hireId);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.jobDetails.tr,),
        leading: CustomBack(),
        actions: [


                GestureDetector(
                    onTap: (){
                      if(!_controller.hireLoading.value)
                      showDialog(context: context,
                          builder: (BuildContext context){
                            return  UserHistoryDetailsAlert(id:_controller.hireDetails.value.id!,);
                          }
                      );
                    },
                    child: const CustomImage(imageSrc: AppIcons.trash,size: 24,)),
          SizedBox(width: 20.w,)
        ],
      ),
        // CustomAppBar(appBarContent:Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     GestureDetector(
        //       onTap: (){
        //         Get.back();
        //       },
        //       child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.blue_100,),
        //     ),
        //     CustomText(
        //       text: AppStrings.jobDetails.tr,
        //       color: AppColors.blue_100,
        //       fontSize: 18,
        //       fontWeight: FontWeight.w500,
        //     ),
        //     if(!_controller.hireLoading.value)
        //       GestureDetector(
        //           onTap: (){
        //             showDialog(context: context,
        //                 builder: (BuildContext context){
        //                   return  UserHistoryDetailsAlert(id:_controller.hireDetails.value.id!,);
        //                 }
        //             );
        //           },
        //           child: const CustomImage(imageSrc: AppIcons.trash,size: 24,))
        //   ],),)
      body: Obx(()=>_controller.hireLoading.value?const CustomLoader():
         LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl:_controller.hireDetails.value.image!,
                        placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade400,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            )),
                        errorWidget: (context, url, error) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Colors.grey.withOpacity(0.6)),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),

                              color: Colors.grey,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      ),


                      const SizedBox(height: 16,),
                       CustomText(
                        text: _controller.hireDetails.value.name!,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 10,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
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
                          Flexible(
                            child: CustomText(
                              text: _controller.hireDetails.value.address!,
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
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
                                color: AppColors.green_10,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: CustomText(
                              text: _controller.hireDetails.value.status!,
                              fontSize: 12,
                              color: AppColors.green_100,
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
                            text: DateFormat.jm().format(_controller.hireDetails.value.createAt!),
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
                            text: "${DateFormat.d().format(_controller.hireDetails.value.createAt!)} ${DateFormat.MMMM().format(_controller.hireDetails.value.createAt!)}",
                            fontWeight: FontWeight.w500,
                            left: 4,
                          ),
                        ],
                      ),
                    ],
                  )
              );
            }),
      ),
    );
  }
}
