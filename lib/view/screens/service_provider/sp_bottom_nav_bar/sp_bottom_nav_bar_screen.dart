/*


import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/sp_home_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:flutter/material.dart';

class SpBottomNavBarScreen extends StatefulWidget {
  const SpBottomNavBarScreen({super.key, required int currentIndex});

  @override
  State<SpBottomNavBarScreen> createState() => _SpBottomNavBarScreenState();
}

class _SpBottomNavBarScreenState extends State<SpBottomNavBarScreen> {
  late int currentIndex = 0;
  List screens = [
    const SpHomeScreen(),
    const SpJobHistoryScreen(),
    const SpProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: AppColors.blue_100,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (updateIndex) {
              setState(() {
                currentIndex = updateIndex;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(
                        imageSrc: currentIndex == 0
                            ? AppIcons.home
                            : AppIcons.home_un,
                        size: 24,imageColor: currentIndex == 0 ? AppColors.white: AppColors.white
                    ),
                  ),
                  label: "asdfg"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(
                        imageSrc:
                        currentIndex == 1 ? AppIcons.clock : AppIcons.history_s,
                        size: 24,imageColor: currentIndex == 1 ? AppColors.white: AppColors.white
                    ),
                  ),
                  label: "sdfgh"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(
                      imageSrc:
                      currentIndex == 2 ? AppIcons.userCircle : AppIcons.profile_s,
                      size: 24,imageColor: currentIndex == 2 ? AppColors.white: AppColors.white
                    ),
                  ),
                  label: ""),
            ],
          ),
          body: screens[currentIndex],
        ));
  }
}


*/













import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/sp_home_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:find_worker/view/screens/user/home/home/home_screen.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sp_home/Controller/home_controller.dart';


class SpBottomNavBarScreen extends StatefulWidget {

  SpBottomNavBarScreen({super.key, required this.currentIndex});

  late int currentIndex;

  @override
  State<SpBottomNavBarScreen> createState() => _SpBottomNavBarScreenState();
}

class _SpBottomNavBarScreenState extends State<SpBottomNavBarScreen> {


  static const List<Widget> screens = <Widget>[
    SpHomeScreen(),
    SpJobHistoryScreen(),
    SpProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
     final _homeController = Get.put(SpHomeController());

    List<Widget> manuBarItems = [
      MenuBarItems(
          text: AppStrings.home,
          index: 0,
          selectedIndex: widget.currentIndex,
          image:  AppIcons.home_un),
      MenuBarItems(
          text:AppStrings.history,
          index: 1,
          selectedIndex: widget.currentIndex,
          image: AppIcons.clock
      ),
      MenuBarItems(
          text: AppStrings.profile,
          index: 2,
          selectedIndex: widget.currentIndex,
          image: AppIcons.userCircle
      ),

    ];
    return SafeArea(
      bottom: false,
      child: Scaffold(

        extendBody: true,
        bottomNavigationBar: Container(
          height: 88,
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
        ): Center(
          child: CustomImage(

          imageColor:selectedIndex == index  ? AppColors.white:AppColors.white,size:24, imageSrc: image),
        ),
      ],
    );
  }
}
