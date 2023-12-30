
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/sp_home_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:wrcontacts/view/screens/user/category/category_screen.dart';
import 'package:wrcontacts/view/screens/user/home/home/home_screen.dart';
import 'package:wrcontacts/view/screens/user/user_hire_list/user_hire_list/user_hire_list_screen.dart';
import 'package:wrcontacts/view/screens/user/user_profile/user_profile_screen.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../helper/SystemChromeHelper/system_chrome.dart';
import '../category/Controller/category_controller.dart';
import '../home/Controller/home_controller.dart';
import '../user_profile/Controller/profile_controller.dart';


class UserBottomNavBarScreen extends StatefulWidget {

  UserBottomNavBarScreen({super.key, required this.currentIndex});

  late int currentIndex;

  @override
  State<UserBottomNavBarScreen> createState() => _UserBottomNavBarScreenState();
}

class _UserBottomNavBarScreenState extends State<UserBottomNavBarScreen> {


  @override
  void initState() {
    SystemChromeHelper.enableSystemChrome();
    displayBannerAd();
    super.initState();
  }

  static  List<Widget> screens = <Widget>[
    HomeScreen(),
     CategoryScreen(isBack:false,),
    const UserHireListScreen(),
    const UserProfileScreen()
  ];

  BannerAd? banner_ad;

  bool _isLoaded=false;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Test Mode
      : 'ca-app-pub-3940256099942544/2934735716' //  Test Mode
  ;
  final adUnitIdLive = Platform.isAndroid
      ? 'ca-app-pub-1976486377144082/5956333402' //  Live Mode
      : 'ca-app-pub-1976486377144082/9700137293';
  displayBannerAd(){
    banner_ad=BannerAd(
      adUnitId: adUnitIdLive,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
          // setState(() {
          //   _isLoaded = true;
          // });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
    setState(() {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<UserHomeController>();
    Get.delete<CategoryController>();
    Get.delete<UserProfileController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    List<BottomNavigationBarItem> bottomBarItem=[
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomImage(imageSrc:widget.currentIndex==0?AppIcons.home:AppIcons.home_un,),
      ),label:"Home"),
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomImage(imageSrc:widget.currentIndex==1?AppIcons.viewGrid:AppIcons.viewGridUn),
      ),label:"Category"),
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomImage(imageSrc:widget.currentIndex==2?AppIcons.speakerphone:AppIcons.speakerphoneUn),
      ),label:"Hire List"),
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomImage(imageSrc:widget.currentIndex==3?AppIcons.userCircle:AppIcons.userCircleUn),
      ),label:"Profile"),
    ];


    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !_isLoaded?Container():Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: banner_ad!.size.width.toDouble(),
              height: banner_ad!.size.height.toDouble(),
              child: AdWidget(ad: banner_ad!),
            ),
          ),
          BottomNavigationBar(
            backgroundColor:const Color(0xFF0668E3),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
            currentIndex: widget.currentIndex,
            selectedLabelStyle: const TextStyle(fontWeight:FontWeight.w500),
            items:bottomBarItem,
          onTap: (value){
            setState(() {
              widget.currentIndex=value;
            });
          },
          ),
        ],
      ),
      body: screens[widget.currentIndex],
    );
  }
}






//
// class MenuBarItems extends StatelessWidget {
//   MenuBarItems(
//       {super.key,
//         required this.image,
//         required this.index,
//         required this.selectedIndex,
//         required this.text});
//   final String image;
//   final String text;
//
//   final int index;
//   final int selectedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         selectedIndex == index ?  Column(
//           children: [
//             CustomImage(
//                 imageColor:selectedIndex == index  ? AppColors.white:AppColors.white,size:24,
//                 imageSrc: image),
//             CustomText(
//               fontSize: 12,
//               fontWeight:selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
//               text: text,
//               color: selectedIndex == index ? AppColors.white : AppColors.white,
//               top: 6,
//               bottom: 4,
//             ),
//           ],
//         ): CustomImage(
//
//             imageColor:selectedIndex == index  ? AppColors.white:AppColors.white,size:24, imageSrc: image),
//       ],
//     );
//   }
// }
//
//


