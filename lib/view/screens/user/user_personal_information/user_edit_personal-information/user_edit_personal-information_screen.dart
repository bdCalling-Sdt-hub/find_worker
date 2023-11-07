import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/model/user_model.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_images.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/buttons/custom_button.dart';
import 'package:find_worker/view/widgets/custom_elevated_loading_button/custom_elevated_loading_button.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:find_worker/view/widgets/text_field/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserEditPersonalInformation extends StatefulWidget {
  const UserEditPersonalInformation({super.key});

  @override
  State<UserEditPersonalInformation> createState() => _UserEditPersonalInformationState();
}

class _UserEditPersonalInformationState extends State<UserEditPersonalInformation> {

  final userImage = AppImages.profileJhon;

  File? imageFile;
  final imagePicker = ImagePicker();
  String? imageUrl;
  String name = "";
  String email = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();



  UserModel loggedInUser = UserModel();

  Future<void> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      FirebaseFirestore.instance.collection(AppConstants.users).doc(user.uid).get().then((value){
        loggedInUser = UserModel.fromMap(value);

        name = loggedInUser.userName ?? "";
        email = loggedInUser.email ?? "";

        nameController.text = loggedInUser.userName ?? "";
        emailController.text = loggedInUser.email ?? "";
        phoneController.text = loggedInUser.phone ?? "";
        addressController.text = loggedInUser.address ?? "";
        dayController.text = loggedInUser.dob!.day.toString();
        monthController.text = loggedInUser.dob!.month.toString();
        yearController.text = loggedInUser.dob!.year.toString();
        imageSrc = loggedInUser.imageSrc;
        setState(() {});
      });
    }
  }

  void openGallery(BuildContext context) async{

    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 120,
        maxWidth: 120
    );

    setState(() {
      if(pickedFile != null)
      {
        imageFile = File(pickedFile.path);
      }
    });

    Get.back();
  }

  void openCamera(BuildContext context)  async{

    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 120,
        maxWidth: 120
    );
    setState(() {

      if(pickedFile != null)
      {
        imageFile = File(pickedFile.path);
      }
    });

    Get.back();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(
            "Choose option",
            style: GoogleFonts.publicSans(color: AppColors.black_100, fontWeight: FontWeight.w500, fontSize: 16)
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Divider(height: 1, color: Colors.blue),
              ListTile(
                onTap: (){
                  openGallery(context);
                },
                title: Text("Gallery", style: GoogleFonts.publicSans(color: Colors.black)),
                leading: const Icon(Icons.account_box,color: Colors.black),
              ),
              const Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  openCamera(context);
                },
                title: Text("Camera", style: GoogleFonts.publicSans(color: Colors.black)),
                leading: const Icon(Icons.camera,color: Colors.black),
              ),
            ],
          ),
        ),);
    });
  }

  @override
  void initState()
  {
    getUserInfo();
    super.initState();
  }

  List<String> genderList = ["Male", "Female", "Others"];
  int selectedGender = 0;
  bool isClicked = false;

  void changeGender(int index) {
    selectedGender = index;
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
                    padding: const EdgeInsets.only(top: 44,left: 20,right: 20,bottom: 24),
                    child: Column(
                      children: [

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
                        const SizedBox(height: 34,),
                        Center(
                          child: SizedBox(
                            height: 130,
                            width: 130,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    height: 130,
                                    decoration:  BoxDecoration(
                                        image: imageFile != null ?  DecorationImage(
                                          image: FileImage(File(imageFile!.path)),
                                        ):loggedInUser.imageSrc != null ? DecorationImage(
                                            image: CachedNetworkImageProvider(imageSrc!),
                                            fit: BoxFit.cover
                                        ) : DecorationImage(
                                            image: AssetImage(userImage),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () => showChoiceDialog(context),
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
                                    textEditingController: nameController,
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
                                     /* Expanded(
                                          child:Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsetsDirectional.symmetric(horizontal:15,vertical: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Color(0xffE2E2E2)
                                                  // color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                                )
                                            ),
                                            child: TextFormField(
                                              controller:dayController,
                                              textAlign: TextAlign.center,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Empty";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                hintText: "DD",
                                                contentPadding: EdgeInsets.zero,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),

                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                                                LengthLimitingTextInputFormatter(2),
                                                DayFormatter(),
                                              ],
                                            ),
                                          )
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child:Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsetsDirectional.symmetric(horizontal:15,vertical: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: const Color(0xffE2E2E2)
                                                  //    color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                                )
                                            ),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller:monthController,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Empty";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                hintText: "MM",
                                                contentPadding: EdgeInsets.zero,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),

                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                                                LengthLimitingTextInputFormatter(2),
                                                MonthFormatter(),
                                              ],
                                            ),
                                          )
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsetsDirectional.symmetric(horizontal:15,vertical: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: const Color(0xffE2E2E2)
                                                  //   color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blue_100
                                                )
                                            ),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller:yearController,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Empty";
                                                }else if(value.length<4){
                                                  return "Valid Year";
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                hintText: "YYYY",
                                                contentPadding: EdgeInsets.zero,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),

                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                                                LengthLimitingTextInputFormatter(4),
                                                YearFormatter(),
                                              ],
                                            ),
                                          )
                                      ),*/
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
                                          textEditingController: phoneController,
                                          textAlign: TextAlign.start,
                                          hintText: AppStrings.phoneNumber,
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
                                    textEditingController: addressController,
                                    maxLines: 5,
                                    textAlign: TextAlign.start,
                                    hintText: 'Enter your address',
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
                                  const CustomText(
                                    text: AppStrings.email,
                                    color: AppColors.black_100,
                                    fontWeight: FontWeight.w500,
                                    top: 16,
                                    bottom: 8,
                                  ),
                                  CustomTextField(
                                    readOnly: true,
                                    textEditingController: emailController,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
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
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  isLoading ? const Center(child: CircularProgressIndicator()) :CustomButton(
                                    buttonWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      updateUserData();
                                    },
                                    titleText: AppStrings.update,
                                    titleColor: AppColors.white,
                                    buttonBgColor: AppColors.blue_100,
                                    titleSize: 18,
                                    titleWeight: FontWeight.w600,
                                  ),
                                ]
                            )
                        )
                      ],
                    )
                );
              }),
        ));
  }
  String? imageSrc;
  bool isLoading = false;

  void updateUserData() async{

    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;

    if (imageFile != null) {
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/${user!.uid}');
      TaskSnapshot uploadTask = await storageReference.putFile(File(imageFile!.path),SettableMetadata(contentType: 'image/jpeg'));
      imageSrc = await uploadTask.ref.getDownloadURL();
    }

    if(user != null){
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).update({
        "username" : nameController.text,
        "address" : addressController.text,
        "phone" : phoneController.text,
        "imageSrc" : imageSrc,
        "dob" : "${dayController.text}-${monthController.text}-${yearController.text}"
      });
    }

    Fluttertoast.showToast(
        msg: "Profile updated successfully",
        backgroundColor: AppColors.blue_100,
        textColor: AppColors.black_100,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );

    setState(() {
      isLoading = false;
    });
  }


}


class YearFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;

    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 5 && pLen == 4) {
      // User has entered a complete 4-digit year, do not modify
      return currText;
    } else if (cLen == 1) {
      // Ensure the first character is within 1-2 (i.e., 19 or 20)
      int y1 = int.parse(cText);
      if (y1 < 1 || y1 > 2) {
        // Remove the first character
        cText = '';
      }
    } else if (cLen == 2) {
      // Ensure the first two characters are within 19 or 20
      int y1 = int.parse(cText.substring(0, 2));
      if (y1 < 19 || y1 > 20) {
        // Remove the second character
        cText = cText.substring(0, 1);
      }
    } else if (cLen > 4) {
      // User has entered more than 4 digits, truncate it
      cText = cText.substring(0,4);
    }

    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: cText.length),
    );
  }
}



class DayFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
class MonthFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    String cText = currText.text;
    int cLen = cText.length;

    if (cLen == 1) {
      // If the input has only one character, it can only be 0, 1, 2, or 3.
      if (int.tryParse(cText) == null || int.parse(cText) > 3) {
        // Invalid input, remove the character.
        return TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    } else if (cLen == 2) {
      // If the input has exactly 2 characters, validate the month.
      int? mm = int.tryParse(cText);
      if (mm == null || mm < 1 || mm > 12) {
        // Invalid month, keep only the first character.
        return TextEditingValue(
          text: cText.substring(0, 1),
          selection: TextSelection.collapsed(offset: 1),
        );
      }
    }

    // If the input is valid, allow it to continue.
    return currText;
  }
}