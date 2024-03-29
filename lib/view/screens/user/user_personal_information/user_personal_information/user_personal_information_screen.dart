import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/model/user_model.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_images.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/user/user_profile/Controller/profile_controller.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_back.dart';

class UserPersonalInformationScreen extends StatefulWidget {
  const UserPersonalInformationScreen({super.key});

  @override
  State<UserPersonalInformationScreen> createState() =>
      _UserPersonalInformationScreenState();
}

class _UserPersonalInformationScreenState
    extends State<UserPersonalInformationScreen> {
  final _profileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.blue_100,
            title: Text(AppStrings.personalInformation.tr,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.white),),
            leading: CustomBack(iconColor: AppColors.white,),
          ),
          // appBar: CustomAppBar(
          //   appBarBgColor: AppColors.blue_100,
          //
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
          //           color: AppColors.white,
          //         ),
          //       ),
          //        CustomText(
          //         text: AppStrings.personalInformation.tr,
          //         color: AppColors.white,
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //       ),
          //       const SizedBox()
          //     ],
          //   ),
          // ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
              () => SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: AppColors.blue_100,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16))),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: BoxShape.circle,
                              image: _profileController
                                          .userData.value.imageSrc !=
                                      null
                                  ? _profileController
                                              .userData.value.imageSrc !=
                                          ""
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(_profileController
                                              .userData.value.imageSrc!))
                                      :  DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              AppIcons.unSplashProfileImage),
                                        )
                                  :  DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          AppIcons.unSplashProfileImage),
                                    )),
                        ),
                        CustomText(
                          text:
                              _profileController.userData.value.userName ?? "",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.white,
                          top: 24,
                          bottom: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoute.userEditPersonalInformationScreen,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:  CustomText(
                              text: 'Edit Profile'.tr,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 20),
                    child: Column(
                      children: [
                        _dataTile(
                            icon: AppIcons.user,
                            title: _profileController.userData.value.userName ??
                                ""),
                        _divider(),
                        _dataTile(
                            icon: AppIcons.dateOfBirth,
                            title: _profileController.userData.value.dob != null
                                ? "${_profileController.userData.value.dob!.day}-${_profileController.userData.value.dob!.month}-${_profileController.userData.value.dob!.year}"
                                : ""),
                        _divider(),
                        _dataTile(
                            icon: AppIcons.gender,
                            title:
                                _profileController.userData.value.gender ?? ""),
                        _divider(),
                        _dataTile(
                            icon: AppIcons.phone,
                            title: _profileController.userData.value.phone ==
                                    null
                                ? ""
                                : "${_profileController.userData.value.phoneCode} ${_profileController.userData.value.phone!}"),
                        _divider(),
                        _dataTile(
                            icon: AppIcons.mail,
                            title:
                                _profileController.userData.value.email ?? ""),
                        _divider(),
                        _dataTile(
                            icon: AppIcons.location,
                            title: _profileController.userData.value.address ??
                                ""),
                      ],
                    ),
                  ),
                ],
              )),
            );
          }),
        ));
  }

  _divider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Divider(
          color: Color(0xFFCDE1F9),
          height: 1,
        ),
      );

  _dataTile({required String icon, required String title}) {
    return Row(
      children: [
        CustomImage(
          imageSrc: icon,
          size: 18,
        ),
        Flexible(
          child: CustomText(
            text: title,
            left: 16.w,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
