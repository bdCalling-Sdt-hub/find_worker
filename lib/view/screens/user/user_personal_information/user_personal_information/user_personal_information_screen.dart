import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPersonalInformationScreen extends StatefulWidget {
  const UserPersonalInformationScreen({super.key});

  @override
  State<UserPersonalInformationScreen> createState() => _UserPersonalInformationScreenState();
}

class _UserPersonalInformationScreenState extends State<UserPersonalInformationScreen> {

  List<Map<String,String>> categoryInfo =[
    {
      'icon':AppIcons.user,
      'info':AppStrings.personalInformation,
    },
    {
      'icon':AppIcons.dateOfBirth,
      'info':'22-03-1998',
    },
    {
      'icon':AppIcons.gender,
      'info':AppStrings.male,
    },
    {
      'icon':AppIcons.phone,
      'info':'+44 26537 26347',
    },
    {
      'icon':AppIcons.mail,
      'info':'smith@gmail.com',
    },
    {
      'icon':AppIcons.location,
      'info':'Abu Dhabi',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(
            appBarBgColor: AppColors.blue_100,
            appBarContent:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.white,),
              ),
              const CustomText(
                text: AppStrings.personalInformation,
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,

              ),
              const SizedBox()
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsets.only(top: 24,bottom: 24),
                          width: MediaQuery.of(context).size.width,
                          decoration:const BoxDecoration(
                              color: AppColors.blue_100,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16)
                              )
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/images/profile_smith.png'),
                                    )
                                ),
                              ),
                              const CustomText(
                                text: 'Smith John',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: AppColors.white,
                                top: 24,
                                bottom: 16,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoute.userEditPersonalInformationScreen);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:  const CustomText(
                                    text: 'Edit Profile',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.blue_100,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                            child: Column(
                              children: List.generate(categoryInfo.length, (index) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.only(bottom: 16),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                ),
                                child:   Row(
                                  children: [
                                    CustomImage(imageSrc: categoryInfo[index]['icon'].toString(),size: 18,),
                                    CustomText(
                                      text: categoryInfo[index]['info'].toString(),
                                      left: 12,
                                    )
                                  ],
                                ),
                              ),),
                            )
                          ),
                        ),

                      ],
                    )
                );
              }),
        ));
  }
}
