import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_constents.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutAlert extends StatefulWidget {
  const LogOutAlert({super.key});

  @override
  State<LogOutAlert> createState() => _LogOutAlertState();
}

class _LogOutAlertState extends State<LogOutAlert> {
  final _authController = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      elevation: 0,
      title: Column(
        children: [
           CustomText(
            maxLines: 2,
            text: AppStrings.doYouWantToLogoutYourProfile.tr,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black_100,
            bottom: 24,
          ),
          Row(
            children: [
              Expanded(
                  child:InkWell(
                    onTap: (){
                     _authController.signOut(AppConstants.userType);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: AppColors.blue_100),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Obx(()=>_authController.isSignOutLoad.value?CircularProgressIndicator():
                             CustomText(
                              text: AppStrings.yes.tr,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blue_100,
                            ),
                          ),
                        )
                    ),
                  )
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(

                        decoration: BoxDecoration(
                            color: AppColors.blue_100,
                            borderRadius:
                            BorderRadius.circular(8)),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12),
                          child:CustomText(
                            text: AppStrings.no.tr,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        )),
                  )),
            ],
          )
        ],
      ),
    );
  }
}