import 'package:cached_network_image/cached_network_image.dart';
import 'package:wrcontacts/model/service_by_user_model.dart';
import 'package:wrcontacts/model/user_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_icons.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/user/user_service_details/Controller/user_service_details_controller.dart';
import 'package:wrcontacts/view/widgets/custom_button.dart';

import 'package:wrcontacts/view/widgets/image/custom_image.dart';
import 'package:wrcontacts/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/Language/language_controller.dart';


class UserServiceDetailsHireNoeBottomModal extends StatefulWidget {
  UserServiceDetailsHireNoeBottomModal({super.key,required  this.userModel,required this.number,required this.userImage,required this.userByServiceModel});

  String userImage;
  String number;
  UserModel userModel;
  UserByServiceModel userByServiceModel;


  @override
  State<UserServiceDetailsHireNoeBottomModal> createState() => _UserServiceDetailsHireNoeBottomModalState();
}

class _UserServiceDetailsHireNoeBottomModalState extends State<UserServiceDetailsHireNoeBottomModal> {

  final _controller =Get.put(UserServiceDetailsController());
  final _localizationController = Get.put(LocalizationController(sharedPreferences:Get.find()));


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration:const  ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF0668E3)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: Column(
        children: [
           CustomText(
            text: AppStrings.approved.tr,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            bottom: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              widget.userImage.isEmpty? Container(
          height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                shape: BoxShape.circle,
                image: DecorationImage(image:AssetImage(AppIcons.unSplashProfileImage),)
            ),
          )  :CachedNetworkImage(imageUrl:widget.userImage,
              imageBuilder: (context,imageProvider){
                return Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                    shape: BoxShape.circle,
                    image:DecorationImage(image: imageProvider,fit: BoxFit.fill)
                  ),
                );
              },
                placeholder:(context,value){
                return Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                     color: Colors.grey.withOpacity(0.7)
                  ),
                );
                },
                errorWidget:(context,v,e){
                return  Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.7)
                  ),
                );
                },


              ),
              const SizedBox(width: 10,),
               Flexible(child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(widget.userByServiceModel.providerName!,style:const TextStyle(fontWeight:FontWeight.w500,color:Colors.black,fontSize: 18),),
                      ),
                      Row(
                        children: [
                          const CustomImage(
                            imageSrc: AppIcons.star,
                            size: 12,
                          ),
                          CustomText(
                            text: '(${widget.userByServiceModel.averageRating})',
                            fontSize: 12,
                            left: 4,
                          ),
                        ],
                      )

                    ],
                  ),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(AppStrings.service.tr,style:TextStyle(fontWeight:FontWeight.w500,color:Colors.black,fontSize: 18),),
                      Flexible(child: Text(_localizationController.selectIndex==0?widget.userByServiceModel.serviceName??"" : widget.userByServiceModel.serviceNameArabic??"",style:TextStyle(fontWeight:FontWeight.w500,color:Colors.black,fontSize: 18),),
                      ),


                    ],
                  )
                    ],
              ))


            ],
          ),
          const SizedBox(height:30,),


        Obx(()=>
           CustomButton(onTap:(){
            // _controller.hireNow(widget.userByServiceModel,widget.number,widget.userModel);
          },
              loading:_controller.hireLoading.value,
              text:"Call"),
        )

        ],
      ),
    );
  }
}
