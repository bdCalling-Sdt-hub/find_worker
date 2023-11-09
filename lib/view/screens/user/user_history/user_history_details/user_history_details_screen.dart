import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_worker/model/hire_model.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_history/user_history_details/inner_widgets/user_history_details_alert.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class UserHistoryDetailsScreen extends StatefulWidget {
   UserHistoryDetailsScreen({super.key,required this.historyModel,required this.index});
  final HireModel historyModel;
  final int index;


  @override
  State<UserHistoryDetailsScreen> createState() => _UserHistoryDetailsScreenState();
}

class _UserHistoryDetailsScreenState extends State<UserHistoryDetailsScreen> {





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
              const CustomText(
                text: AppStrings.jobDetails,
                color: AppColors.blue_100,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              GestureDetector(
                  onTap: (){
                    showDialog(context: context,
                        builder: (BuildContext context){
                            return  UserHistoryDetailsAlert(id:widget.historyModel.id!,index:widget.index,);
                        }
                    );
                  },
                  child: const CustomImage(imageSrc: AppIcons.trash,size: 24,))
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl:widget.historyModel.image!,
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
                          text: widget.historyModel.name!,
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
                                text: widget.historyModel.contact!,
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
                            const CustomText(
                              text: AppStrings.address,
                            ),
                            Flexible(
                              child: CustomText(
                                text: widget.historyModel.address!,
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
                        const CustomText(
                          text: AppStrings.aboutJob,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          bottom: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: AppStrings.status,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 11),
                              decoration: BoxDecoration(
                                  color: AppColors.green_10,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: CustomText(
                                text: widget.historyModel.status!,
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
                              text: AppStrings.service,
                            ),
                            CustomText(
                              text: widget.historyModel.serviceName!,
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
                              text: DateFormat.jm().format(widget.historyModel.createAt!),
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: AppStrings.date,
                            ),
                            CustomText(
                              text: "${DateFormat.d().format(widget.historyModel.createAt!)} ${DateFormat.MMMM().format(widget.historyModel.createAt!)}",
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                      ],
                    )
                );
              }),
        ));
  }
}
