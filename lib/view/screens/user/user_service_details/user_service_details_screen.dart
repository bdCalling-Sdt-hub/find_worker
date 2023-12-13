import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrcontacts/model/service_by_user_model.dart';
import 'package:wrcontacts/model/user_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_service_details/Controller/user_service_details_controller.dart';
import 'package:wrcontacts/view/screens/user/user_service_details/inner_widgets/user_service_details_hire_now_bottom_modal.dart';

import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wrcontacts/view/widgets/custom_button.dart';

import '../../../../helper/AdMob/ad_display.dart';

class UserServiceDetailsScreen extends StatefulWidget {
  const UserServiceDetailsScreen({super.key});

  @override
  State<UserServiceDetailsScreen> createState() =>
      _UserServiceDetailsScreenState();
}

class _UserServiceDetailsScreenState extends State<UserServiceDetailsScreen> {
  UserByServiceModel userByServiceModel = Get.arguments;

  final _userServiceDetailsController = Get.put(UserServiceDetailsController());
  @override
  void initState() {
    _userServiceDetailsController
        .getTopReviews(userByServiceModel.providerUid!);
    interstitialAdd();
    super.initState();
  }
  interstitialAdd() {
    Future.delayed(Duration(seconds:3), () {
      AdDsiplay().loadInterstitial();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 16,
            color: AppColors.blue_100,
          ),
        ),
        title: CustomText(
          text: AppStrings.serviceDetails.tr,
          color: AppColors.blue_100,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(
          () => _userServiceDetailsController.loading.value
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: userByServiceModel.image!,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: userByServiceModel.providerName!,
                              fontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.star,
                                size: 12,
                              ),
                              CustomText(
                                text: "(${userByServiceModel.averageRating})",
                                fontWeight: FontWeight.w500,
                                left: 4,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Location',
                          ),
                          Flexible(
                            child: CustomText(
                              text: userByServiceModel.location!,
                              fontWeight: FontWeight.w600,
                              left: 4,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
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
                              text: userByServiceModel.serviceName!,
                              fontWeight: FontWeight.w600,
                              left: 4,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      if (_userServiceDetailsController
                          .topReviewList.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 16),
                          height: 1,
                          color: AppColors.blue_20,
                        ),
                      if (_userServiceDetailsController
                          .topReviewList.isNotEmpty)
                        const CustomText(
                          text: 'Top Reviews',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          bottom: 16,
                        ),
                      if (_userServiceDetailsController
                          .topReviewList.isNotEmpty)
                        ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final demoData = _userServiceDetailsController
                                  .topReviewList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CustomText(
                                          text: demoData.userName!,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const CustomImage(
                                            imageSrc: AppIcons.star,
                                            size: 12,
                                          ),
                                          CustomText(
                                            text: '(${demoData.rating})',
                                            fontSize: 12,
                                            left: 4,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CustomText(
                                          text: demoData.content!,
                                          fontSize: 12,
                                          color: AppColors.black_60,
                                        ),
                                      ),
                                      CustomText(
                                        text: DateFormat('dd MMM')
                                            .format(demoData.createAt!),
                                        fontSize: 12,
                                        color: AppColors.black_60,
                                        left: 4,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                            itemCount: _userServiceDetailsController
                                        .topReviewList.length >
                                    4
                                ? 3
                                : _userServiceDetailsController
                                    .topReviewList.length),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        height: 1,
                        color: AppColors.blue_20,
                      ),
                      CustomText(
                        text: AppStrings.description.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        bottom: 16,
                      ),
                      CustomText(
                        text: userByServiceModel.description!,
                        maxLines: 9,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(AppConstants.users)
                              .doc(userByServiceModel.providerUid!)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              final userData =
                                  UserModel.fromMap(snapshot.data!);
                              return userData.status == "Online"
                                  ? Obx(()=>
                                     CustomButton(
                                       loading: _userServiceDetailsController.hireLoading.value,
                                        onTap: () {
                                          _userServiceDetailsController.hireNow(userByServiceModel, "${userData.phoneCode} ${userData.phone}", userData);
                                          // showModalBottomSheet(
                                          //     backgroundColor:
                                          //         Colors.transparent,
                                          //     barrierColor:
                                          //         Colors.transparent,
                                          //     context: context,
                                          //     builder:
                                          //         (BuildContext context) {
                                          //       return UserServiceDetailsHireNoeBottomModal(
                                          //         userModel: userData,
                                          //         userImage:
                                          //             userData.imageSrc!,
                                          //         userByServiceModel:
                                          //             userByServiceModel,
                                          //         number:
                                          //             "${userData.phoneCode} ${userData.phone}",
                                          //       );
                                          //     });
                                        },
                                     text: AppStrings.hireNow.tr,
                                      ),
                                  )
                                  : CustomButton(
                                     color: Colors.white10,
                                      onTap: () {
                                        // Get.snackbar("Alerts!",
                                        //     "The service provider is now busy.");
                                      },
                                     text:AppStrings.hireNow.tr,
                                    );
                            } else {
                              return CustomButton(
                                color: Colors.white10,
                                onTap: () {},
                             text:AppStrings.hireNow,

                              );
                            }
                          })
                    ],
                  )),
        );
      }),
    );
  }
}
