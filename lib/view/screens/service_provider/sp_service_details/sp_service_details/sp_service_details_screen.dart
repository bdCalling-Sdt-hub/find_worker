import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/model/service_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_service_details/sp_edit_service_details/sp_edit_service_details_screen.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:wrcontacts/view/widgets/buttons/custom_button.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/AdMob/ad_display.dart';
import '../../../../widgets/custom_back.dart';

class SpServiceDetailsScreen extends StatefulWidget {
  const SpServiceDetailsScreen({super.key});

  @override
  State<SpServiceDetailsScreen> createState() =>
      _SpServiceDetailsScreenState();
}

class _SpServiceDetailsScreenState extends State<SpServiceDetailsScreen> {


  ServiceModel  data= Get.arguments;
  Rx<ServiceModel>  serviceModel= ServiceModel().obs;
  update(ServiceModel value){
    serviceModel.value=value;
    serviceModel.refresh();
  }
  @override
  void initState() {
    serviceModel.value=data;
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
    return Scaffold(
      backgroundColor: AppColors.white,
          appBar: AppBar(title: Text(AppStrings.serviceDetails.tr),leading:CustomBack(),),

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
      //        CustomText(
      //         text: AppStrings.serviceDetails.tr,
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
            return Obx(()=>
               SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.3),
                            image:  DecorationImage(
                                image:NetworkImage(serviceModel.value.image!),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           CustomText(
                            text: AppStrings.location.tr,
                          ),
                          CustomText(
                            text: serviceModel.value.location!,
                            fontWeight: FontWeight.w600,
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
                            text: AppStrings.service.tr,
                          ),
                          Flexible(
                            child: CustomText(
                              text: serviceModel.value.serviceName!,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              left: 4,
                            ),
                          ),
                        ],
                      ),
                       CustomText(
                        text: AppStrings.description.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        bottom: 8,
                        top: 16,
                      ),
                       CustomText(
                        text:serviceModel.value.description!,
                        maxLines: 9,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )),
            );
          }),
      bottomNavigationBar: BottomNavButton(buttonText: AppStrings.edit.tr, onTap: (){
        Get.to(SpEditServiceScreen(callback:update, serviceModel:serviceModel.value,));
       // Get.toNamed(AppRoute.spEditServiceDetailsScreen,arguments: serviceModel.value);
      })
    );
  }
}
