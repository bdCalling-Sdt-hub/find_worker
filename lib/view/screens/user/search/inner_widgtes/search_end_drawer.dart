import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/buttons/bottom_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEndDrawer extends StatefulWidget {

  const SearchEndDrawer({super.key});

  @override
  State<SearchEndDrawer> createState() => _SearchEndDrawerState();
}

class _SearchEndDrawerState extends State<SearchEndDrawer> {

  List<String> genderList = [
    "Home Clean",
    "Car Wash",
    "Air Condition Maintenance",
    "Housekeeper",
    "Home Maintenance",
    "Pipe Fitter",
    "Jens Salon",
    "Man Driver",
    "Manicure & Pedicure",
    "Woman Driver",
    "Ladies Salon",
    "Home Business",
    "Butcher",
    "Private Tutor",
    "Gypsum Board & Floor",
    "Car Tires Repair",
    "Car Recovery",
    "Catering",
    "Cable Fixing",
  ];
  int selectedGender= -1;


  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFF818181)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child:  const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.blue_100,
                  size: 24,
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1, width: MediaQuery.of(context).size.width,
                    color: AppColors.blue_20,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: genderList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          mainAxisExtent: 24
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          selectedGender = index;
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          decoration: ShapeDecoration(
                            color: index == selectedGender ? AppColors.blue_100 : AppColors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: index == selectedGender ? AppColors.blue_100 :  AppColors.blue_100 ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            genderList[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              color: index == selectedGender ? AppColors.white : AppColors.blue_100,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 200),
                  BottomNavButton(
                    buttonText: AppStrings.apply,
                    onTap: () {
                      /*Get.to(()=> const OtpScreen());*/
                    },

                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
