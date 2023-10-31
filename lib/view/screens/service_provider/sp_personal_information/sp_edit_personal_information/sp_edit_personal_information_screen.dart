import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SpEditPersonalInformationScreen extends StatefulWidget {
  const SpEditPersonalInformationScreen({super.key});

  @override
  State<SpEditPersonalInformationScreen> createState() => _SpEditPersonalInformationScreenState();
}

class _SpEditPersonalInformationScreenState extends State<SpEditPersonalInformationScreen> {
  List<String> genderList = ["Male", "Female", "Others"];
  int selectedGender = 0;
  bool isClicked = false;
  void changeGender(int index) {
    selectedGender = index;
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                    child: Column(
                      children: [
                       const SizedBox(height: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.blue_100,),
                            ),
                            const CustomText(
                              text: AppStrings.editPersonalInformation,
                              color: AppColors.blue_100,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,

                            ),
                            const SizedBox()
                          ],),
                        SizedBox(height: 34,),
                        Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    height: 130,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/images/profile_smith.png'),
                                        )
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(2),
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: AppColors.blue_100,
                                        shape: BoxShape.circle,
                                        // image: DecorationImage(image: AssetImage('assets/images/profile_icon.png')),
                                      ),
                                      child: const CustomImage(
                                        imageSrc:AppIcons.camera,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    text: AppStrings.fullName,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    textAlign: TextAlign.start,
                                    hintText: 'Enter Your Name',
                                    hintStyle: GoogleFonts.poppins(
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
                                  const CustomText(
                                    text: AppStrings.dateOfBirth,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8,
                                    top: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          hintText: AppStrings.dd,
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black_40),
                                          inputTextStyle: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: AppColors.black_100),
                                          fieldBorderColor: AppColors.blue_10,
                                          fieldBorderRadius: 8,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          hintText: AppStrings.mm,
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black_40),
                                          inputTextStyle: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: AppColors.black_100),
                                          fieldBorderColor: AppColors.blue_10,
                                          fieldBorderRadius: 8,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          hintText: AppStrings.yyyy,
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black_40),
                                          inputTextStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: AppColors.black_100),
                                          fieldBorderColor: AppColors.blue_10,
                                          fieldBorderRadius: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const CustomText(
                                    text: AppStrings.gender,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8,
                                    top: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        genderList.length,
                                            (index) => GestureDetector(
                                          onTap: () => changeGender(index),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                padding:
                                                const EdgeInsetsDirectional
                                                    .all(0.5),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                        color:
                                                        AppColors.blue_100),
                                                    shape: BoxShape.circle),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: index ==
                                                          selectedGender
                                                          ? AppColors.blue_100
                                                          : Colors.transparent,
                                                      shape: BoxShape.circle),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                genderList[index],
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.black_100,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),

                                  const CustomText(
                                    text: AppStrings.phoneNumber,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: 60,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 8),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColors.blue_10)),
                                              child: IntlPhoneField(
                                                initialCountryCode: 'MX',
                                                disableLengthCheck: true,
                                                showDropdownIcon: false,
                                                showCountryFlag: true,
                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                    )),
                                                onChanged: (phone) {
                                                  print(phone.completeNumber);
                                                },
                                              ))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomTextField(
                                          textAlign: TextAlign.start,
                                          hintText: AppStrings.enterYourEmail,
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
                                      ),
                                    ],
                                  ),
                                  const CustomText(
                                    text: AppStrings.address,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    maxLines: 5,
                                    textAlign: TextAlign.start,
                                    hintText: 'Enter your address',
                                    hintStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black_40),
                                    inputTextStyle: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_100),
                                    fieldBorderColor: AppColors.blue_10,
                                    fieldBorderRadius: 8,
                                  ),
                                  const CustomText(
                                    text: AppStrings.email,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    textAlign: TextAlign.start,
                                    hintText: AppStrings.enterYourEmail,
                                    hintStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black_40),
                                    inputTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_100),
                                    fieldBorderColor: AppColors.blue_10,
                                    fieldBorderRadius: 8,
                                  ),

                                  const SizedBox(
                                    height: 24,
                                  ),
                                  CustomButton(
                                    buttonWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      Get.toNamed(AppRoute.spPersonalInformationScreen);
                                    },
                                    titleText: AppStrings.update,
                                    titleColor: AppColors.white,
                                    buttonBgColor: AppColors.blue_100,
                                    titleSize: 18,
                                    titleWeight: FontWeight.w600,
                                  ),
                                ]))
                      ],
                    )
                );
              }),
        ));
  }
}
