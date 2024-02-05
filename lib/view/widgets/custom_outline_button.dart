import 'package:wocontacts/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomOutlineButton extends StatelessWidget {
   CustomOutlineButton({super.key,this.color, required this.onTap,required this.text ,this.loading=false,this.width,this.height});
  Function() onTap;
  String text;
  bool loading;
  double? height;
  double? width;
  Color? color;

  @override

  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed:loading? (){}:onTap,
        style: ElevatedButton.styleFrom(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(8.r)
         ),
         side: const BorderSide(width: 1,color:AppColors.blue_100),
          backgroundColor: color??const Color(0xffFFFFFF),
            minimumSize:Size(width??Get.width, height??50.h),

        ),
        child:loading? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color:AppColors.blue_100,),
        ):Text(text,style:const TextStyle(color:AppColors.blue_100),));
  }
}
