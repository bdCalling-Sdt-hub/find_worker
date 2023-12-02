import 'package:find_worker/view/screens/user/user_auth/user_auth_controller/user_auth_controller.dart';
import 'package:find_worker/view/widgets/custom_button.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_strings.dart';

class AccountDeleteAccount extends StatelessWidget {
   AccountDeleteAccount({
    super.key,
  });

  final _authController = Get.put(AuthenticationController());


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title:ListTile(title:Text("Enter your email to delete your account.".tr,style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
      // trailing: IconButton(onPressed:(){
      //   Get.back();
      // }, icon:Icon(Icons.close,color: Colors.red,)),
      //
      // ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child:Text("Enter your email to delete your account.".tr,style:TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15.sp),),),
          InkWell(onTap:(){
            Get.back();
          }, child:Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Icon(Icons.close,color: Colors.red,),
          )),

        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.email.tr),
          SizedBox(height: 7.h,),
          CustomTextField(
            textEditingController: _authController.accountDeleteCtrl,
            hintText:AppStrings.enterYourEmail.tr,
          ),
          SizedBox(height: 20.h,),
          Obx(()=>
             CustomButton(onTap: (){
              _authController.deleteController();
            }, text:"Delete Account".tr,loading:_authController.isAccountDeleteLoading.value,),
          )

        ],
      ),
    );
  }
}