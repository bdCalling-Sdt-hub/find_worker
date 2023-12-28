import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_images.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_add_new_service/sp_add_new_service_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/inner_widgets/sp_home_bottom_modal.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_job_details/sp_job_details_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_profile/Controller/profile_controller.dart';
import 'package:wrcontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wrcontacts/view/widgets/custom_button.dart';
import 'package:wrcontacts/view/widgets/custom_loader.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/on_off_switch/on_off_switch.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../model/hire_model.dart';
import '../../../widgets/custom_switch.dart';

class SpHomeScreen extends StatefulWidget {
  const SpHomeScreen({super.key});

  @override
  State<SpHomeScreen> createState() => _SpHomeScreenState();
}

class _SpHomeScreenState extends State<SpHomeScreen> {
  bool status = false;
  final _controller = ValueNotifier<bool>(false);
  final _homeController = Get.put(SpHomeController());
  final _profileController = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        appBarContent:
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              //Image.asset(AppIcons.appLogo,height:35,width: 22,),
              //  _profileController.userData.value.imageSrc==null||_profileController.userData.value.imageSrc==""? Container(
              //   height: 45,
              //   width: 45,
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.all(
              //           color: Colors.grey.shade200,
              //           width: 0.5
              //       ),
              //       image: const DecorationImage(
              //           image:AssetImage(AppIcons.unSplashProfileImage),fit: BoxFit.fill)
              //   ),
              //
              //
              // ):Container(
              //   height: 45,
              //   width: 45,
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.all(
              //           color: Colors.grey.shade200,
              //           width: 0.5
              //       ),
              //       image: DecorationImage(
              //           image:NetworkImage(_profileController.userData.value.imageSrc??""),fit: BoxFit.fill)),
              // ),

      StreamBuilder(
          stream: _homeController.getItems(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }else{
              debugPrint("user data get : ${snapshot.data!.data()}");
              var da=snapshot.data!;
              debugPrint("user data get : ${da['status']}");
                if(da['status']=="Online"){
                  print("Online");
                  _homeController.status.value=true;
                  _homeController.refresh();

                }else{
                  _homeController.status.value=false;

                  print("Offline");
                }


              return Obx(()=>
                  SizedBox(
                    height:100,
                    child: Switch(value:_homeController.status.value, onChanged:(value){
                _homeController.updateStatusData(value);

             }),
                  )
              //    CustomSwicth(onChanged: (bool value) {
              //     _homeController.updateStatusData();
              //
              //   },
              //     value:_homeController.status.value,active:AppStrings.online.tr,inActive:AppStrings.offline.tr,),




              );


            }

          },
      ),


              // SizedBox(
              //   height:35,
              //   child: Obx(()=>
              //      LiteRollingSwitch(
              //       //initial value
              //       value:_homeController.status.value,
              //       width: 100,
              //       textOn: 'Online',
              //       textOff: 'Offline',
              //        colorOn:AppColors.blue_100,
              //        colorOff:AppColors.black_20 ,
              //       iconOn: Icons.done,
              //       iconOff: Icons.remove_circle_outline,
              //       textSize: 12.0,
              //       onChanged: (bool state) {
              //         _homeController.updateStatusData();
              //         print('Current State of SWITCH IS: $state');
              //       }, onTap:(){
              //
              //     }, onDoubleTap:(){
              //
              //     }, onSwipe:(){
              //
              //     },
              //     ),
              //   ),
              // ),
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
            return  Obx(()=>_homeController.loading.value?const Center(child: CustomLoader()):
               StreamBuilder<List<HireModel>>(
                stream: _homeController.getHistoryList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CustomLoader()
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<HireModel> historyList = snapshot.data ?? [];

                      return SingleChildScrollView(
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
                            ) : historyList.isEmpty?Container(
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
                                  final data=historyList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(SpJobDetailsScreen(jobId:data.id!,));
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
                                                      color:data.status==AppConstants.approved?const Color(0xFFE7F0FD) :data.status==AppConstants.working?Colors.cyan.shade50: AppColors.yellow_10,
                                                      borderRadius:
                                                      BorderRadius.circular(4)),
                                                  child:CustomText(
                                                    text:data.status!,
                                                    fontSize: 12,
                                                    color:data.status==AppConstants.approved?AppColors.blue_100:data.status==AppConstants.working?Colors.cyan.shade800:AppColors.yellow_100,
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
                            }, itemCount: historyList.length)



                          ],
                        ),
                      );

                  }
                },
              ),
            );
        // return Obx(
        //   () => _homeController.loading.value
        //       ? const CustomLoader()
        //       : RefreshIndicator(
        //         onRefresh: ()async {
        //           _homeController.getData(false);
        //         },
        //         child: SingleChildScrollView(
        //           physics: const AlwaysScrollableScrollPhysics(),
        //             padding: const EdgeInsets.symmetric(
        //                 vertical: 24, horizontal: 20),
        //             child: Column(
        //               children: [
        //                 _userProfile(),
        //                 const SizedBox(
        //                   height: 24,
        //                 ),
        //
        //                 _homeController.serviceList.isEmpty?Column(
        //                   children: [
        //                     SizedBox(height:94.h ,),
        //                     Image.asset(AppImages.empty,height: 100,width: 100,),
        //                     const SizedBox(height: 10),
        //                     CustomButton(onTap:(){
        //                       Get.to(const SpAddNewServiceScreen());
        //
        //                     }, text:"Add Service",width: 200.w,height: 44.h,)
        //
        //                   ],
        //                 ) : _homeController.historyList.isEmpty?Container(
        //                   height: Get.height/2,
        //                   width: double.infinity,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(8.r),
        //                     border: Border.all(
        //                       color: const Color(0xFFCDE1F9),
        //                       width: 1
        //                     )
        //                   ),
        //                   child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Image.asset(AppImages.empty,height: 100,width: 100,),
        //                       const SizedBox(height: 10),
        //                         Text(AppStrings.noJobsPending.tr)
        //                     ],
        //                   ),
        //
        //                 ):
        //                     ListView.separated(
        //                         physics: const NeverScrollableScrollPhysics(),
        //                         shrinkWrap: true,
        //                         itemBuilder:(context,index){
        //                           final data=_homeController.historyList[index];
        //                       return GestureDetector(
        //                         onTap: () {
        //                           Get.to(SpJobDetailsScreen(jobId:data.id!,));
        //                         },
        //                         child: Container(
        //                           padding: const EdgeInsets.all(16),
        //                           decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(8),
        //                             border: Border.all(
        //                                 color: AppColors.blue_100, width: 1),
        //                           ),
        //                           child: Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: [
        //                                CustomText(
        //                                 text:data.name!,
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.w500,
        //                               ),
        //                               const Divider(color:Color(0xFFCDE1F9),),
        //
        //                               Row(
        //                                 mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                    CustomText(
        //                                     text: AppStrings.status.tr,
        //                                   ),
        //                                   Flexible(
        //                                     child: Container(
        //                                       padding: const EdgeInsets.symmetric(
        //                                           vertical: 4, horizontal: 11),
        //                                       decoration: BoxDecoration(
        //                                           color:data.status==AppConstants.approved?const Color(0xFFE7F0FD) :data.status==AppConstants.working?Colors.cyan.shade50: AppColors.yellow_10,
        //                                           borderRadius:
        //                                           BorderRadius.circular(4)),
        //                                       child:CustomText(
        //                                         text:data.status!,
        //                                         fontSize: 12,
        //                                         color:data.status==AppConstants.approved?AppColors.blue_100:data.status==AppConstants.working?Colors.cyan.shade800:AppColors.yellow_100,
        //                                       ),
        //                                     ),
        //                                   )
        //                                 ],
        //                               ),
        //                               const SizedBox(
        //                                 height: 10,
        //                               ),
        //                                Row(
        //                                 mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                    CustomText(
        //                                     text: AppStrings.service.tr,
        //                                   ),
        //                                   SizedBox(width: 10.w,),
        //                                   Flexible(
        //                                     child: CustomText(
        //                                       text:data.serviceName!,
        //                                       fontWeight: FontWeight.w500,
        //                                       left: 4,
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                               const SizedBox(
        //                                 height: 10,
        //                               ),
        //                                Row(
        //                                 mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                    CustomText(
        //                                     text: AppStrings.time.tr,
        //                                   ),
        //                                   CustomText(
        //                                     text: DateFormat.jm().format(data.createAt!),
        //                                     fontWeight: FontWeight.w500,
        //                                     left: 4,
        //                                   ),
        //                                 ],
        //                               ),
        //                               const SizedBox(
        //                                 height: 10,
        //                               ),
        //                                Row(
        //                                 mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                    CustomText(
        //                                     text: AppStrings.date.tr,
        //                                   ),
        //                                   Flexible(
        //                                     child: CustomText(
        //                                       text:"${DateFormat.d().format(data.createAt!)} ${DateFormat.MMMM().format(data.createAt!)}",
        //                                       fontWeight: FontWeight.w500,
        //                                       left: 4,
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       );
        //
        //                     }, separatorBuilder:(context,index){
        //                       return SizedBox(height: 10.h,);
        //                     }, itemCount: _homeController.historyList.length)
        //
        //
        //
        //               ],
        //             )),
        //       ),
        // );
      }),
    );
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
                                        image: const DecorationImage(image:AssetImage( AppIcons.unSplashProfileImage)),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.blue_100),
                                      ),

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
