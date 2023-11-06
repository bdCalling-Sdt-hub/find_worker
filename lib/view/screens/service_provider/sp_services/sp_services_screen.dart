import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/view/screens/service_provider/sp_services/Controller/service_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpServicesScreen extends StatefulWidget {
  const SpServicesScreen({super.key});

  @override
  State<SpServicesScreen> createState() => _SpServicesScreenState();
}

class _SpServicesScreenState extends State<SpServicesScreen> {
  final _serviceController= Get.put(ServiceController());

  @override
  void initState() {
    _serviceController.getService();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              appBarContent: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                      color: AppColors.blue_100,
                    ),
                  ),
                  CustomText(
                    text: 'Services'.tr,
                    color: AppColors.blue_100,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox()
                ],
              ),
            ),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Obx(()=>_serviceController.loading.value?const CustomLoader():
                     SingleChildScrollView(
                        padding:
                        const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _serviceController.serviceList.length,
                                itemBuilder:(context,index){
                                  var data=_serviceController.serviceList[index];
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
                    ),
                  );
                }),

        ));
  }
}
