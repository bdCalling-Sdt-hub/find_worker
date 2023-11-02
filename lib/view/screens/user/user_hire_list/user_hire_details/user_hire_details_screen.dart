import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_hire_list/user_hire_details/inner_widgets/hire_details_alert.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHireDetailsScreen extends StatefulWidget {
  const UserHireDetailsScreen({super.key});

  @override
  State<UserHireDetailsScreen> createState() => _UserHireDetailsScreenState();
}

class _UserHireDetailsScreenState extends State<UserHireDetailsScreen> {
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
              text: 'Hire Details'.tr,
              color: AppColors.blue_100,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox()
          ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image:const DecorationImage(image: AssetImage('assets/images/john_doe_profile.png'),
                            fit: BoxFit.cover
                            )
                          ),
                        ),
                       const SizedBox(height: 16,),
                       const Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           CustomText(
                             text: 'John Doe',
                             fontSize: 18,
                             fontWeight: FontWeight.w500,
                           ),
                           Row(
                             children: [
                               CustomImage(
                                 imageSrc: AppIcons.star,size: 12,
                               ),
                               CustomText(
                                 text: '(4.5)',
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
                            CustomText(
                              text: 'Contact'.tr,
                            ),
                            CustomText(
                              text: '+44 12344 1234',
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
                              text: 'Address'.tr,
                            ),
                            CustomText(
                              text: 'Abu Dhabi',
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
                          text: 'About Job'.tr,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          bottom: 16,
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              CustomText(
                              text: 'Status'.tr,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 11),
                              decoration: BoxDecoration(
                                  color: AppColors.yellow_10,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: const CustomText(
                                text: AppStrings.pending,
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
                              text: 'Service'.tr,
                            ),
                            CustomText(
                              text: AppStrings.carWash,
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
                              text: 'Time'.tr,
                            ),
                            CustomText(
                              text: '12:00 am',
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
                              text: 'Date'.tr,
                            ),
                            CustomText(
                              text: '12 September',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 72,),
                        CustomButton(
                          buttonWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return HireDetailsAlert();
                                }
                            );
                          },
                          titleText: 'Complete'.tr,
                          titleColor: AppColors.white,
                          buttonBgColor: AppColors.green_100,
                          titleSize: 18,
                          titleWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: 'Click on the'.tr,style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xff5A5A5A),
                              )),
                              TextSpan(text: ' Complete '.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: Color(0xff5A5A5A),)),
                              TextSpan(text: 'button after getting your current service to complete the service status.'.tr,style: TextStyle(
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
