
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/sp_home_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:find_worker/view/screens/user/category/category_screen.dart';
import 'package:find_worker/view/screens/user/home/home/home_screen.dart';
import 'package:find_worker/view/screens/user/user_hire_list/user_hire_list/user_hire_list_screen.dart';
import 'package:find_worker/view/screens/user/user_profile/user_profile_screen.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../home/Controller/home_controller.dart';


class UserBottomNavBarScreen extends StatefulWidget {

  UserBottomNavBarScreen({super.key, required this.currentIndex});

  late int currentIndex;

  @override
  State<UserBottomNavBarScreen> createState() => _UserBottomNavBarScreenState();
}

class _UserBottomNavBarScreenState extends State<UserBottomNavBarScreen> {


  static  List<Widget> screens = <Widget>[
    HomeScreen(),
    const CategoryScreen(),
    const UserHireListScreen(),
    const UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final _homeController = Get.put(UserHomeController());

    List<Widget> manuBarItems = [
      MenuBarItems(
          text: AppStrings.home,
          index: 0,
          selectedIndex: widget.currentIndex,
          image:  AppIcons.home_un),
      MenuBarItems(
          text:AppStrings.category,
          index: 1,
          selectedIndex: widget.currentIndex,
          image: AppIcons.viewGrid
      ),
      MenuBarItems(
          text: AppStrings.hireList,
          index: 2,
          selectedIndex: widget.currentIndex,
          image: AppIcons.speakerphone
      ),
      MenuBarItems(
          text: AppStrings.profile,
          index: 3,
          selectedIndex: widget.currentIndex,
          image: AppIcons.userCircle
      ),

    ];
    return SafeArea(
      bottom: false,
      child: Scaffold(

        extendBody: true,
        bottomNavigationBar: Container(
          height: 88.h,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(top: 15),
          decoration:   const BoxDecoration(
            color: AppColors.blue_100,

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(manuBarItems.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.currentIndex = index;
                  });
                },
                child: manuBarItems[index],
              );
            }),
          ),
        ),
        body: screens[widget.currentIndex],
      ),
    );
  }
}

class MenuBarItems extends StatelessWidget {
  MenuBarItems(
      {super.key,
        required this.image,
        required this.index,
        required this.selectedIndex,
        required this.text});
  final String image;
  final String text;

  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        selectedIndex == index ?  Column(
          children: [
            CustomImage(
                imageColor:selectedIndex == index  ? AppColors.white:AppColors.white,size:24,
                imageSrc: image),
            CustomText(
              fontSize: 12,
              fontWeight:selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
              text: text,
              color: selectedIndex == index ? AppColors.white : AppColors.white,
              top: 6,
              bottom: 4,
            ),
          ],
        ): CustomImage(

            imageColor:selectedIndex == index  ? AppColors.white:AppColors.white,size:24, imageSrc: image),
      ],
    );
  }
}
