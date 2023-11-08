import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,required this.onTap,required this.text ,this.loading=false,this.width,this.height});
  Function() onTap;
  String text;
  bool loading;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed:onTap,
        style: ElevatedButton.styleFrom(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(8)
         ),
          backgroundColor: const Color(0xff0668E3),
            minimumSize:Size(width??Get.width, height??50),

        ),
        child:loading? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        ):Text(text));
  }
}
