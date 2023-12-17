import 'package:wrcontacts/helper/SystemChromeHelper/system_chrome.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_home/sp_home_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:wrcontacts/view/screens/user/home/home/home_screen.dart';
import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sp_home/Controller/home_controller.dart';
import '../sp_job_history/Controller/sp_history_controller.dart';
import '../sp_profile/Controller/profile_controller.dart';


class SpBottomNavBarScreen extends StatefulWidget {

  SpBottomNavBarScreen({super.key, required this.currentIndex});

  late int currentIndex;

  @override
  State<SpBottomNavBarScreen> createState() => _SpBottomNavBarScreenState();
}

class _SpBottomNavBarScreenState extends State<SpBottomNavBarScreen> {
  @override
  void initState() {
    SystemChromeHelper.enableSystemChrome();
    super.initState();
  }

  static  List<Widget> screens = <Widget>[
    SpHomeScreen(),
    SpJobHistoryScreen(),
    SpProfileScreen(),
  ];


  @override
  void dispose() {
    SpProfileController profileController = SpProfileController();
    SpHomeController homeController = SpHomeController();
    SpHistoryController spController = SpHistoryController();
    profileController.dispose();
    homeController.dispose();
    spController.dispose();
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
         child: CustomImage(imageSrc:widget.currentIndex==1?AppIcons.history_s:AppIcons.historyUn),
       ),label:"History"),
       BottomNavigationBarItem(icon:Padding(
         padding: const EdgeInsets.all(8.0),
         child: CustomImage(imageSrc:widget.currentIndex==2?AppIcons.userCircle:AppIcons.userCircleUn),
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
