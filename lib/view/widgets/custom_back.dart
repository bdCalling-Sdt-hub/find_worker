import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:(){
      Get.back();
    }, icon:const Icon(Icons.arrow_back_ios_new_outlined,size:18,));
  }
}
