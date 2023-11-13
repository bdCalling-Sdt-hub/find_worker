import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_add_new_service/sp_add_new_service_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/inner_widgets/sp_home_bottom_modal.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_details/sp_job_details_screen.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/on_off_switch/on_off_switch.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class SpHomeScreen extends StatefulWidget {
  const SpHomeScreen({super.key});

  @override
  State<SpHomeScreen> createState() => _SpHomeScreenState();
}

class _SpHomeScreenState extends State<SpHomeScreen> {
  bool status = false;
  final _controller = ValueNotifier<bool>(false);
  final _homeController = Get.put(SpHomeController());

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
                 CustomText(
                  text: AppStrings.logo.tr,
                  color: AppColors.blue_100,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height:35,
                  child: Obx(()=>
                     LiteRollingSwitch(
                      //initial value
                      value:_homeController.status.value,
                      width: 100,
                      textOn: 'Online',
                      textOff: 'Offline',
                       colorOn:AppColors.blue_100,
                       colorOff:AppColors.black_20 ,
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      textSize: 12.0,
                      onChanged: (bool state) {
                        _homeController.updateStatusData();
                        print('Current State of SWITCH IS: $state');
                      }, onTap:(){

                    }, onDoubleTap:(){

                    }, onSwipe:(){

                    },
                    ),
                  ),
                ),
                // OnOffSwitch(
                //   controller: _controller,
                //   activeColor: AppColors.blue_100,
                //   inactiveColor: AppColors.black_100,
                //   activeChild: Text(
                //     'Online',
                //     style: GoogleFonts.poppins(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color: AppColors.white),
                //   ),
                //   inactiveChild: Text(
                //     'Offline',
                //     style: GoogleFonts.poppins(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color: AppColors.white),
                //   ),
                //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                //   width: 80,
                //   height: 26.0,
                //   enabled: true,
                //   disabledOpacity: 0.8,
                // ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.spNotificationScreen);
                    },
                    child: const CustomImage(
                      imageSrc: AppIcons.bell,
                      size: 24,
                    ))
              ],
            ),
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Obx(
              () => _homeController.loading.value
                  ? const CustomLoader()
                  : RefreshIndicator(
                    onRefresh: ()async {
                      _homeController.getData(false);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 20),
                        child: Column(
                          children: [
                            _userProfile(),
                            const SizedBox(
                              height: 24,
                            ),

                            _homeController.serviceList.isEmpty?Column(
                              children: [
                                SizedBox(height:94.h ,),
                                Image.asset(AppImages.empty,height: 100,width: 100,),
                                const SizedBox(height: 10),
                                CustomButton(onTap:(){
                                  Get.to(const SpAddNewServiceScreen());

                                }, text:"Add Service",width: 200.w,height: 44.h,)

                              ],
                            ) : _homeController.historyList.isEmpty?Container(
                              height: Get.height/2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: const Color(0xFFCDE1F9),
                                  width: 1
                                )
                              ),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages.empty,height: 100,width: 100,),
                                  const SizedBox(height: 10),
                                    Text(AppStrings.noJobsPending.tr)
                                ],
                              ),

                            ):
                                ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:(context,index){
                                      final data=_homeController.historyList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(SpJobDetailsScreen(hireModel:data,index: index));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.blue_100, width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           CustomText(
                                            text:data.name!,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const Divider(color:Color(0xFFCDE1F9),),

                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                               CustomText(
                                                text: AppStrings.status.tr,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 4, horizontal: 11),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.yellow_10,
                                                      borderRadius:
                                                      BorderRadius.circular(4)),
                                                  child:CustomText(
                                                    text:data.status!,
                                                    fontSize: 12,
                                                    color: AppColors.yellow_100,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                               CustomText(
                                                text: AppStrings.service.tr,
                                              ),
                                              SizedBox(width: 10.w,),
                                              Flexible(
                                                child: CustomText(
                                                  text:data.serviceName!,
                                                  fontWeight: FontWeight.w500,
                                                  left: 4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                               CustomText(
                                                text: AppStrings.time.tr,
                                              ),
                                              CustomText(
                                                text: DateFormat.jm().format(data.createAt!),
                                                fontWeight: FontWeight.w500,
                                                left: 4,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                               CustomText(
                                                text: AppStrings.date.tr,
                                              ),
                                              Flexible(
                                                child: CustomText(
                                                  text:"${DateFormat.d().format(data.createAt!)} ${DateFormat.MMMM().format(data.createAt!)}",
                                                  fontWeight: FontWeight.w500,
                                                  left: 4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                }, separatorBuilder:(context,index){
                                  return SizedBox(height: 10.h,);
                                }, itemCount: _homeController.historyList.length)



                          ],
                        )),
                  ),
            );
          }),
        ));
  }

  Container _userProfile() {
    return Container(
                          height: 115,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.blue_100, width: 1),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF3F3F3),
                                Color(0xFFCCE0FA),
                              ],
                            ),
                          ),
                          child: Row(
                            children: [
                              _homeController.userData.value.imageSrc !=
                                          null &&
                                      _homeController
                                          .userData.value.imageSrc!.isNotEmpty
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.blue_100),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  _homeController.userData
                                                      .value.imageSrc!))),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      padding: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.blue_100),
                                      ),
                                      child: Image.asset(
                                          'assets/images/person.png'),
                                    ),
                              const SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CustomText(
                                          text: _homeController
                                              .userData.value.userName!,
                                          fontSize: 18,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const CustomImage(
                                            imageSrc: AppIcons.star,
                                            size: 12,
                                          ),
                                          CustomText(
                                            text:
                                                '(${_homeController.userData.value.averageRating ?? 0.0})',
                                            fontWeight: FontWeight.w500,
                                            left: 4,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  _homeController.serviceList.isEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: AppStrings.service +
                                                  (1).toString(),
                                              color: AppColors.black_60,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const Flexible(
                                              child: CustomText(
                                                text: "None",
                                                fontSize: 14,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: _homeController
                                                      .serviceList.length >
                                                  2
                                              ? 2
                                              : _homeController
                                                  .serviceList.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: AppStrings.service +
                                                      (index + 1).toString(),
                                                  color: AppColors.black_60,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Flexible(
                                                  child: CustomText(
                                                    text: _homeController
                                                        .serviceList[index]
                                                        .serviceName!,
                                                    fontSize: 14,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                ],
                              ))
                            ],
                          ),
                        );
  }
}
