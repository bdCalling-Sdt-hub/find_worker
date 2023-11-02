import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/buttons/bottom_nav_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpAddNewServiceScreen extends StatefulWidget {
  const SpAddNewServiceScreen({super.key});

  @override
  State<SpAddNewServiceScreen> createState() =>
      _SpAddNewServiceScreenState();
}
class _SpAddNewServiceScreenState extends State<SpAddNewServiceScreen> {
  int selectedItem = 0;
  bool isSelected = false;
  List<String> serviceType = [
    'Home Clean',
    'Car Wash',
    'Farmer',
    'Air Condition Maintenance',
    'Pipe Fitter',
    'Jens Salon',
    'Man Driver',
    'Woman Driver',
    'Ladies Salon',
    'Home Business',
    'Butcher',
    'Private Tutor',
    'Henna',
    'Movers',
    'Gypsum Board & Floor',
    'Car Tires Repair',
    'Car Recovery',
    'Catering',
    'Cable Fixing',
  ];
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
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                      color: AppColors.blue_100,
                    ),
                  ),
                   CustomText(
                    text: 'Add New Service'.tr,
                    color: AppColors.blue_100,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox()
                ],
              ),
            ),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                      padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // image: const DecorationImage(
                                      //     image: AssetImage(
                                      //         'assets/images/hire_details_profile.png'),
                                      //     fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.black_100.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(child: CustomImage(imageSrc: AppIcons.camera,size: 18,)),
                                )
                              ],
                            ),
                          ),
                           CustomText(
                            text: 'Service Type'.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            top: 16,
                            bottom: 8,
                          ),
                          TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  isSelected=!isSelected;
                                });
                              }, icon:isSelected ? const Icon(Icons.keyboard_arrow_up,size: 24,color: AppColors.black_80,) : const Icon(Icons.keyboard_arrow_down_rounded,size: 24,color: AppColors.black_80,)
                              ),
                              filled: true,
                              fillColor: AppColors.white,
                              hintText: 'Enter your service'.tr,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_40),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: AppColors.blue_10, width: 1),
                                  gapPadding: 0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: AppColors.blue_10, width: 1),
                                  gapPadding: 0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: AppColors.blue_10, width: 1),
                                  gapPadding: 0),
                            ),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.black_100),


                          ),
                          isSelected ? Container(
                            decoration:const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1, color: Color(0xFF0668E3)),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                )
                            ),
                            child: Column(
                              children: List.generate(
                                serviceType.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedItem = index;
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
                                          left: 16, right: 16, top: 12,),
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
                                            CustomText(
                                              text: serviceType[index].tr,
                                              color: AppColors.black_100,
                                              left: 10,
                                              right: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ): Container(),
                           CustomText(
                            text: 'Location'.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            top: 16,
                            bottom: 8,
                          ),
                          CustomTextField(
                            textAlign: TextAlign.start,
                            hintText: 'Enter your address'.tr,
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_40),
                            inputTextStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.black_100),
                            fieldBorderColor: AppColors.blue_10,
                            fieldBorderRadius: 8,
                          ),
                           CustomText(
                            text: 'Description'.tr,
                            color: AppColors.black_100,
                            fontWeight: FontWeight.w500,
                            top: 16,
                            bottom: 8,
                          ),
                          CustomTextField(
                            maxLines: 7,
                            textAlign: TextAlign.start,
                            hintText: 'Enter service description'.tr,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_40),
                            inputTextStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.black_100),
                            fieldBorderColor: AppColors.blue_10,
                            fieldBorderRadius: 8,
                          ),
                        ],
                      ));
                }),
            bottomNavigationBar: BottomNavButton(buttonText: 'Add Service'.tr, onTap: (){
              Get.toNamed(AppRoute.spServicesScreen);
            })
        ));
  }
}
