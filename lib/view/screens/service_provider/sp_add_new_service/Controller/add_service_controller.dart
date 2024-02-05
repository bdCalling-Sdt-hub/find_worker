import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wocontacts/model/category_model.dart';
import 'package:wocontacts/model/service_model.dart';
import 'package:wocontacts/utils/app_constents.dart';
import 'package:wocontacts/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:wocontacts/view/screens/service_provider/sp_services/Controller/service_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddNewServiceController extends GetxController{

      RxList<CategoryModel> categoryList= <CategoryModel>[].obs;
        ServiceController serviceController=ServiceController();
      FirebaseFirestore  firebaseStorage= FirebaseFirestore.instance;
      final FirebaseStorage _storage = FirebaseStorage.instance;
      final FirebaseAuth _auth = FirebaseAuth.instance;

      TextEditingController serviceTextCtrl=TextEditingController();
      TextEditingController addressTextCtrl=TextEditingController();
      TextEditingController descriptionTextCtrl=TextEditingController();
      final formKey = GlobalKey<FormState>();
      var selectServiceId="".obs;
      var selectService="".obs;
      var selectServiceArabic="".obs;

      var loading= false.obs;
      final ImagePicker picker = ImagePicker();
      late  XFile? image;
       var imagePath="".obs;
      var selectedItem =(-1).obs;
      var uuid = const Uuid();
      RxString selectedOption = 'Direct call'.obs;
// Pick an image.


  picImage()async{
    try {
       image = await picker.pickImage(source: ImageSource.gallery);
       if(image !=null){
         imagePath.value=image!.path;
       }
    } on Exception catch (e) {
      // TODO
    }
  }

  getCategory()async{
    loading(true);
    try {
      var result= await  firebaseStorage.collection(AppConstants.category).get();
      categoryList.value= List<CategoryModel>.from(result.docs.map((x) => CategoryModel.fromJson(x)));
      debugPrint("========> CategoryLength = ${categoryList.length}");
      categoryList.refresh();
    } on Exception catch (e) {
      loading(false);
    }finally{
      loading(false);
    }
  }

  var addServiceLoad=false.obs;

  addService()async{
    if(!addServiceLoad.value){
      if(imagePath.isEmpty){
        Fluttertoast.showToast(msg:"Please Select Image".tr,toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.CENTER);
      }else{
        if(formKey.currentState!.validate()){
          addServiceLoad(true);
          try {
            var result =await firebaseStorage.collection(AppConstants.services).where("provider_uid",isEqualTo:_auth.currentUser!.uid).where("category_id",isEqualTo:selectServiceId.value).get();
            if(result.docs.isEmpty){
              var id =uuid.v4();
              var url=  await uploadImage(id);

              ServiceModel body=ServiceModel(
                  image: url,
                  id:id,
                  serviceName:selectService.value,
                  serviceId: selectServiceId.value,
                  location: addressTextCtrl.text,
                  providerUid:_auth.currentUser!.uid,
                  description:descriptionTextCtrl.text,
                  options: selectedOption.value,
                   createAt: DateTime.now(),
                serviceNameArabic: selectServiceArabic.value,
              );
              await firebaseStorage.collection(AppConstants.services).doc(id).set(body.toJson());
                Get.find<SpHomeController>().getService();
              Fluttertoast.showToast(msg:"Service Added Successful".tr,toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.CENTER);
              await serviceController.getService();
              serviceTextCtrl.clear();
              selectServiceId.value="";
              addressTextCtrl.clear();
              descriptionTextCtrl.clear();
              imagePath.value="";
              selectedOption.value="Direct call";
              selectedItem.value=(-1);
              Get.back();
            }else{
              Fluttertoast.showToast(msg:"This Service Already Added".tr,toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.CENTER);
           //   Get.snackbar("Error","This Service Already Added");
            }

          } on Exception catch (e) {
            debugPrint("Add error. Reason ${e.toString()}");
            // TODO
          }finally{
            addServiceLoad(false);
          }
        }
      }

    }
  }

 Future<String>  uploadImage(String id)async{
   var url="";
    await FirebaseStorage.instance
        .ref()
        .child("Service").child(_auth.currentUser!.uid).child(id)
        .putFile(File(imagePath.value),SettableMetadata(contentType: "image/jpeg"))
        .then((value) async {
      var d = await value.ref.getDownloadURL();
      print("Image link is $d");
     url=d;
    });
    return url;
   }




}