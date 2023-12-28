
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
    super.initState();
  }

  static  List<Widget> screens = <Widget>[
    HomeScreen(),
     CategoryScreen(isBack:false,),
    const UserHireListScreen(),
    const UserProfileScreen()
  ];


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
    // final _homeController = Get.put(UserHomeController());
    // final _categoryController = Get.put(CategoryController());
    // final _profileController = Get.put(UserProfileController());

    // List<Widget> manuBarItems = [
    //   MenuBarItems(
    //       text: AppStrings.home.tr,
    //       index: 0,
    //       selectedIndex: widget.currentIndex,
    //       image:  AppIcons.home_un),
    //   MenuBarItems(
    //       text:AppStrings.category.tr,
    //       index: 1,
    //       selectedIndex: widget.currentIndex,
    //       image: AppIcons.viewGrid
    //   ),
    //   MenuBarItems(
    //       text: AppStrings.hireList.tr,
    //       index: 2,
    //       selectedIndex: widget.currentIndex,
    //       image: AppIcons.speakerphone
    //   ),
    //   MenuBarItems(
    //       text: AppStrings.profile.tr,
    //       index: 3,
    //       selectedIndex: widget.currentIndex,
    //       image: AppIcons.userCircle
    //   ),
    //
    // ];

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
      bottomNavigationBar: BottomNavigationBar(
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


