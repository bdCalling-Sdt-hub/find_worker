import 'package:find_worker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBack extends StatelessWidget {
   CustomBack({super.key,this.iconColor});

  Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:(){
      Get.back();
    }, icon:Icon(Icons.arrow_back_ios_new_outlined,size:18,color:iconColor??AppColors.blue_100,));
  }
}
