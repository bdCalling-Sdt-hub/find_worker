import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/user/user_history/user_history_details/inner_widgets/user_history_details_alert.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHistoryDetailsScreen extends StatefulWidget {
  const UserHistoryDetailsScreen({super.key});

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
                            return const UserHistoryDetailsAlert();
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
                        const CustomText(
                          text: 'John Doe',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Contact',
                            ),
                            CustomText(
                              text: '+44 12344 1234',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.address,
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
                              child: const CustomText(
                                text: AppStrings.pending,
                                fontSize: 12,
                                color: AppColors.green_100,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.service,
                            ),
                            CustomText(
                              text: AppStrings.carWash,
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.time,
                            ),
                            CustomText(
                              text: '12:00 am',
                              fontWeight: FontWeight.w500,
                              left: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppStrings.date,
                            ),
                            CustomText(
                              text: '12 September',
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
