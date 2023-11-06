import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_icons.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/image/custom_image.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPersonalInformationScreen extends StatefulWidget {
  const UserPersonalInformationScreen({super.key});

  @override
  State<UserPersonalInformationScreen> createState() => _UserPersonalInformationScreenState();
}

class _UserPersonalInformationScreenState extends State<UserPersonalInformationScreen> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(
            appBarBgColor: AppColors.blue_100,
            appBarContent:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,size: 16,color: AppColors.white,),
              ),
              const CustomText(
                text: AppStrings.personalInformation,
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,

              ),
              const SizedBox()
            ],),),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                    child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection("Users").doc(firebaseAuth.currentUser?.uid).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'.tr));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: Text("Loading...".tr));
                        }
                        Map<String,dynamic> userData = snapshot.data?.data() as Map<String, dynamic>;
                        final String imageSrc = userData['imageSrc']?? "";
                        final String address = userData['address']?? "";
                        //final Timestamp dob = userData['dob']?? "";
                        final String gender = userData['gender']?? "";
                        final String email = userData['email']?? "";
                        final String phone = userData['phone']?? "";
                        final String username = userData['username']?? "";
                        return Column(
                          children: [
                            Container(
                              padding:const EdgeInsets.only(top: 24,bottom: 24),
                              width: MediaQuery.of(context).size.width,
                              decoration:const BoxDecoration(
                                  color: AppColors.blue_100,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16)
                                  )
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: imageSrc,
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) => const Icon(Icons.person,size: 100),
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    text: username,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.white,
                                    top: 24,
                                    bottom: 16,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.toNamed(AppRoute.userEditPersonalInformationScreen,);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child:  const CustomText(
                                        text: 'Edit Profile',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.blue_100,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                              child: Container(
                                  padding:  const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                                  child: Column(
                                      children: [
                                        Container(
                                          margin:  const EdgeInsets.only(bottom: 16),
                                          padding:  const EdgeInsets.only(bottom: 16),
                                          decoration:  const BoxDecoration(
                                              border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                          ),
                                          child:  Row(
                                            children: [
                                              const CustomImage(imageSrc: AppIcons.user,size: 18,),
                                              CustomText(
                                                text: username,
                                                left: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:  const EdgeInsets.only(bottom: 16),
                                          padding:  const EdgeInsets.only(bottom: 16),
                                          decoration:  const BoxDecoration(
                                              border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                          ),
                                          child: const Row(
                                            children: [
                                              CustomImage(imageSrc: AppIcons.dateOfBirth,size: 18,),
                                              CustomText(
                                                text: '',
                                                left: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:  const EdgeInsets.only(bottom: 16),
                                          padding:  const EdgeInsets.only(bottom: 16),
                                          decoration:  const BoxDecoration(
                                              border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                          ),
                                          child:  Row(
                                            children: [
                                              const CustomImage(imageSrc: AppIcons.gender,size: 18,),
                                              CustomText(
                                                text: gender,
                                                left: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:  const EdgeInsets.only(bottom: 16),
                                          padding:  const EdgeInsets.only(bottom: 16),
                                          decoration:  const BoxDecoration(
                                              border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                          ),
                                          child:  Row(
                                            children: [
                                              const CustomImage(imageSrc: AppIcons.phone,size: 18,),
                                              CustomText(
                                                text: phone,
                                                left: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:  const EdgeInsets.only(bottom: 16),
                                          padding:  const EdgeInsets.only(bottom: 16),
                                          decoration:  const BoxDecoration(
                                              border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                          ),
                                          child:  Row(
                                            children: [
                                              const CustomImage(imageSrc:AppIcons.mail,size: 18,),
                                              CustomText(
                                                text: email,
                                                left: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:  const EdgeInsets.only(bottom: 16),
                                          padding:  const EdgeInsets.only(bottom: 16),
                                          decoration:  const BoxDecoration(
                                              border: Border(bottom: BorderSide(color: AppColors.blue_20,width: 1))
                                          ),
                                          child:  Row(
                                            children: [
                                              const CustomImage(imageSrc: AppIcons.location,size: 18,),
                                              CustomText(
                                                text: address,
                                                left: 12,
                                              )
                                            ],
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),

                          ],
                        );
                      },
                    )
                );
              }),
        ));
  }

}
