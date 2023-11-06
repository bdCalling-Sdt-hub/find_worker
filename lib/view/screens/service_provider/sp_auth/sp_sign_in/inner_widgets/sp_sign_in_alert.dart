import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpSignInAlert extends StatefulWidget {
  const SpSignInAlert({super.key});

  @override
  State<SpSignInAlert> createState() => _SpSignInAlertState();
}

class _SpSignInAlertState extends State<SpSignInAlert> {
  int selectedItem = 0;
  List<String> serviceType = [
    'User',
    'Service Provider'
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      elevation: 0,
      title:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Role Type',
            color: AppColors.black_100,
            fontWeight: FontWeight.w500,
            bottom: 8,
          ),
          Column(
            children: List.generate(
              serviceType.length,
                  (index) {
                return GestureDetector(
                  onTap: () {

                    setState(() {
                      selectedItem = index;
                      if(selectedItem==0){
                        Get.to(UserBottomNavBarScreen(currentIndex: 0));
                      }
                      else if(selectedItem==1){
                        Get.to(SpBottomNavBarScreen(currentIndex: 0));
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: ShapeDecoration(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                         right: 16, top: 12,),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: AppColors.blue_100, width: 1),
                              color: index == selectedItem ? AppColors.blue_100 : AppColors.white,
                            ),
                          ),
                          SizedBox(width: 16,),
                          CustomText(
                            text: serviceType[index],
                            color: AppColors.black_100,
                            left: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}
