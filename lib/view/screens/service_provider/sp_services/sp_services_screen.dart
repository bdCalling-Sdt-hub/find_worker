import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/model/service_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_services/Controller/service_controller.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/Language/language_controller.dart';
import '../../../../helper/SystemChromeHelper/system_chrome.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_back.dart';

class SpServicesScreen extends StatefulWidget {
  const SpServicesScreen({super.key});

  @override
  State<SpServicesScreen> createState() => _SpServicesScreenState();
}

class _SpServicesScreenState extends State<SpServicesScreen> {
  final _serviceController= Get.put(ServiceController());

  final _localizationController = Get.put(LocalizationController(sharedPreferences:Get.find()));

  @override
  void initState() {
    SystemChromeHelper.enableSystemChrome();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    SystemChromeHelper.blueColorSystemChrome();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.white,
          appBar: AppBar(title: Text(AppStrings.service.tr),leading:CustomBack(),),

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
            //         text: 'Services'.tr,
            //         color: AppColors.blue_100,
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //       ),
            //       const SizedBox()
            //     ],
            //   ),
            // ),
            body:LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return StreamBuilder<QuerySnapshot>(
                    stream:FirebaseFirestore.instance.collection(AppConstants.services).where("provider_uid",isEqualTo:_serviceController.auth.currentUser!.uid).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasError){
                        return const CustomLoader();
                      }else if(snapshot.hasData){
                        List<ServiceModel> demoData=  List<ServiceModel>.from(snapshot.data!.docs.map((x) => ServiceModel.fromJson(x)));
                        return  SingleChildScrollView(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: demoData.length,
                                        itemBuilder:(context,index){
                                          var data=demoData[index];
                                          return ListTile(
                                            onTap:(){
                                              Get.toNamed(AppRoute.spServiceDetailsScreen,arguments:data);
                                            },
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            title: Text(data.serviceName!),
                                            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                                          );
                                        }),


                                const SizedBox(height: 16,),
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.spAddNewServiceScreen);
                                  },
                                  child: Row(
                                    children: [
                                      const CustomImage(imageSrc: AppIcons.plusCircle,size: 24,),
                                      CustomText(
                                        text: 'Add New Service'.tr,
                                        color: AppColors.blue_100,
                                        fontSize: 18,
                                        left: 4,
                                        right: 4,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                        );
                      }else{
                        return const CustomLoader();
                      }





                    },

                  );

                }),

             )
    );
  }
}
