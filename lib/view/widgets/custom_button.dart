import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,this.color, required this.onTap,required this.text ,this.loading=false,this.width,this.height});
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
          backgroundColor: color??const Color(0xff0668E3),
            minimumSize:Size(width??Get.width, height??50.h),
        ),
        child:loading? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color: Colors.white,),
        ):Text(text,style: const TextStyle(color: Colors.white),));
  }
}
