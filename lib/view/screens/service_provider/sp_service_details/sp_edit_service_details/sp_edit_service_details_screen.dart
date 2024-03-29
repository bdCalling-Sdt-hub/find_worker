import 'dart:io';

import 'package:wocontacts/core/app_routes.dart';
import 'package:wocontacts/model/service_model.dart';
import 'package:wocontacts/model/user_model.dart';
import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:wocontacts/view/screens/service_provider/sp_add_new_service/Controller/add_service_controller.dart';
import 'package:wocontacts/view/widgets/app_bar/custom_app_bar.dart';
import 'package:wocontacts/view/widgets/buttons/bottom_nav_button.dart';
import 'package:wocontacts/view/widgets/custom_back.dart';
import 'package:wocontacts/view/widgets/custom_button.dart';
import 'package:wocontacts/view/widgets/custom_loader.dart';
import 'package:wocontacts/view/widgets/image/custom_image.dart';
import 'package:wocontacts/view/widgets/text/custom_text.dart';
import 'package:wocontacts/view/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../helper/Language/language_controller.dart';
import '../Controller/edit_service _controller.dart';

class SpEditServiceScreen extends StatefulWidget {
   SpEditServiceScreen({super.key,required this.callback,required this.serviceModel});
  Function(ServiceModel value) callback;
   final ServiceModel serviceModel;


  @override
  State<SpEditServiceScreen> createState() =>
      _SpEditServiceScreenState();
}
class _SpEditServiceScreenState extends State<SpEditServiceScreen> {
  final _controller = Get.put(EditServiceController());
  final _localizationController = Get.put(LocalizationController(sharedPreferences:Get.find()));



  @override
  void initState() {
    _controller.getCategory();
    _controller.imagePath.value="";
    _controller.selectedOption.value=widget.serviceModel.options!;
    _controller.descriptionTextCtrl.text=widget.serviceModel.description!;
    _controller.addressTextCtrl.text=widget.serviceModel.location!;
    _controller.serviceTextCtrl.text=widget.serviceModel.serviceName!;
    _controller.serviceArabicTextCtrl.text=widget.serviceModel.serviceNameArabic!;
    _controller.selectServiceId.value=widget.serviceModel.serviceId!;
    super.initState();
  }

  int selectedItem =(-1);
  bool isSelected = false;








  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(title: Text(AppStrings.editServiceDetails.tr),leading:CustomBack(),),
        // appBar: CustomAppBar(
        //   appBarContent: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       GestureDetector(
        //         onTap: () {
        //           Get.back();
        //         },
        //         child: const Icon(
        //           Icons.arrow_back_ios_new_outlined,
        //           size: 16,
        //           color: AppColors.blue_100,
        //         ),
        //       ),
        //        CustomText(
        //         text: AppStrings.editServiceDetails.tr,
        //         color: AppColors.blue_100,
        //         fontSize: 18,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       const SizedBox()
        //     ],
        //   ),
        // ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Obx(()=>_controller.loading.value?const CustomLoader():
              SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Form(
                    key: _controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Obx(()=>
                              GestureDetector(
                                onTap:(){
                                  _controller.picImage();
                                } ,
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration:_controller.imagePath.isNotEmpty?  BoxDecoration(
                                      color: AppColors.black_100.withOpacity(.5),
                                      image:DecorationImage(image:Image.file(File(_controller.imagePath.value)).image,fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(8)
                                  ):BoxDecoration(
                                      color: AppColors.black_100.withOpacity(.5),
                                      image:DecorationImage(image:NetworkImage(widget.serviceModel.image!),fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: const Center(child: CustomImage(imageSrc: AppIcons.camera,size: 18,)),
                                ),
                              ),
                          ),
                        ),
                         CustomText(
                          text: AppStrings.serviceType.tr,
                          color: AppColors.black_100,
                          fontWeight: FontWeight.w500,
                          top: 16,
                          bottom: 8,
                        ),
                        TextFormField(
                          controller:_localizationController.selectIndex==0? _controller.serviceTextCtrl:_controller.serviceArabicTextCtrl,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Service Type Not Be Empty".tr;
                            } else {
                              return null;
                            }
                          },
                          onTap:(){
                            setState(() {
                              isSelected=!isSelected;
                            });
                          },
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
                            hintText: AppStrings.enterYourService.tr,
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
                              _controller.categoryList.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _controller.serviceTextCtrl.text=_controller.categoryList[index].name!;
                                      _controller.serviceArabicTextCtrl.text=_controller.categoryList[index].nameArabic!;
                                      _controller.selectServiceId.value=_controller.categoryList[index].id!;
                                      isSelected=false;
                                      selectedItem=index;
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
                                           text: _localizationController.selectedIndex==0?  _controller.categoryList[index].name!:_controller.categoryList[index].nameArabic!,
                                            color: AppColors.black_100,
                                            left: 10,
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
                          text: AppStrings.location.tr,
                          color: AppColors.black_100,
                          fontWeight: FontWeight.w500,
                          top: 16,
                          bottom: 8,
                        ),
                        CustomTextField(
                          textEditingController: _controller.addressTextCtrl,
                          textAlign: TextAlign.start,
                          hintText: 'Enter your address'.tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Address Not Be Empty".tr;
                            } else {
                              return null;
                            }
                          },
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
                          text: 'Select Options'.tr,
                          color: AppColors.black_100,
                          fontWeight: FontWeight.w500,
                          top: 16,
                          bottom: 8,
                        ),
                        buildRadioTile("Direct call".tr,"Direct call"),
                        buildRadioTile("Waiting for Approval".tr,"Waiting for Approval"),
                         CustomText(
                          text: AppStrings.description.tr,
                          color: AppColors.black_100,
                          fontWeight: FontWeight.w500,
                          top: 16,
                          bottom: 8,
                        ),
                        CustomTextField(
                          maxLines: 7,
                          textEditingController: _controller.descriptionTextCtrl,
                          textAlign: TextAlign.start,
                          hintText:"Enter service description".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Description Not Be Empty".tr;
                            } else {
                              return null;
                            }
                          },
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
                        // const SizedBox(height: 16,),
                        // GestureDetector(
                        //   onTap: (){
                        //
                        //   },
                        //   child: const Row(
                        //     children: [
                        //       CustomImage(imageSrc: AppIcons.plusCircle,size: 24,),
                        //       CustomText(
                        //         text: AppStrings.addNewService,
                        //         color: AppColors.blue_100,
                        //         fontSize: 18,
                        //         left: 4,
                        //       )
                        //     ],
                        //   ),
                        // )

                      ],
                    ),
                  )),
              );
            }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal:10 ,vertical: 10),
            child: Obx(()=>
                CustomButton(onTap:()async{
       ServiceModel result=await  _controller.updateService(widget.serviceModel);
              widget.callback(result);
              Get.back();

                }, text: AppStrings.update.tr,loading:_controller.updateServiceLoad.value,),
            )  )
    );
  }
  Widget buildRadioTile(String title, String value) {
    return Obx(()=>
        RadioListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          hoverColor: Colors.transparent,

          visualDensity: const VisualDensity(horizontal: 0,vertical: -4),

          title: Text(title,style: const TextStyle(fontSize: 14,),),
          value: value,
          activeColor:AppColors.blue_100,

          groupValue: _controller.selectedOption.value,

          onChanged: (String? val) {
            _controller.selectedOption.value = val!;
          },
        ),
    );
  }
}
