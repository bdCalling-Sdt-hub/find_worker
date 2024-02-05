import 'package:cached_network_image/cached_network_image.dart';
import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_images.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/custom_back.dart';
import 'package:wocontacts/view/widgets/custom_loader.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../helper/Language/language_controller.dart';
import 'category_by_services_controller.dart';

class CategoryByServiceScreen extends StatefulWidget {
  const CategoryByServiceScreen({super.key});

  @override
  State<CategoryByServiceScreen> createState() => _CategoryByServiceScreenState();
}

class _CategoryByServiceScreenState extends State<CategoryByServiceScreen> {
    final _controller = Get.put(CategoryByServiceController());
    final _localizationController = Get.put(LocalizationController(sharedPreferences:Get.find()));

    var parametersData= Get.parameters;

    @override
  void initState() {
      print("=======> $parametersData");
    _controller.getSortedServicesByCategory(parametersData['cat_id']!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(_localizationController.selectedIndex==0? parametersData["cat_name"]!:parametersData['cat_arabic']!),
        leading: CustomBack(),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return  Obx(()=>_controller.loading.value?const CustomLoader()
          : _controller.servicesList.isEmpty? Center(child: Text("No service available!".tr),) :SingleChildScrollView(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            physics:const BouncingScrollPhysics(),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 180
              ),
              itemCount:_controller.servicesList.length, itemBuilder: (BuildContext context, int index) {
             var demoData= _controller.servicesList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.userServiceDetailsScreen,arguments:demoData);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 8, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side:
                        const BorderSide(width: 1, color: Color(0xFF6AA4EE)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl:demoData.image!,
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              )),
                          errorWidget: (context, url, error) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: Colors.grey.withOpacity(0.6)),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),

                                color: Colors.grey,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: CustomText(
                                text: demoData.providerName!,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                CustomImage(
                                    imageType: ImageType.svg,
                                    imageSrc: AppIcons.star),
                                CustomText(
                                  text: "(${demoData.averageRating.toString()})",
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const CustomImage(
                                imageType: ImageType.svg,
                                imageSrc: AppIcons.location),
                            Flexible(
                              child: CustomText(
                                left: 4,
                                text:demoData.location!,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
            },
            ),
          ),
        );
      },),
    );
  }
}
