import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
/*  @override
  void initState() {
    DeviceUtils.authUtils();
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
            appBarContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.blue_100,),
                ),
                Text(
                  AppStrings.notification,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color:  AppColors.blue_100,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox()
              ],)),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
            child: Column(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.blue_100),
                  ),
                  child:   const ListTile(
                    title:CustomText(
                      textAlign: TextAlign.start,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      text: "Welcome to the Find Worker.",
                    ),
                    subtitle: CustomText(
                      color: AppColors.black_60,
                      textAlign: TextAlign.start,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      text: "Fri, 12 am",
                    ),
                  ),
                ),
              ),),
            ),
          );
        },

        ),
      ),
    );
  }
}