import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/model/category_model.dart';
import 'package:find_worker/model/service_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/view/screens/service_provider/sp_services/Controller/service_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
      var loading= false.obs;
      final ImagePicker picker = ImagePicker();
      late  XFile? image;
       var imagePath="".obs;
      var selectedItem =(-1).obs;
      var uuid = const Uuid();
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
      print("========> CategoryLength refresh ");
      loading(false);
    }finally{
      loading(false);
    }
  }

  var addServiceLoad=false.obs;

  addService()async{
    if(!addServiceLoad.value){
      if(imagePath.isEmpty){
        Get.snackbar("Error", "Please Select Image",colorText:Colors.red);
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
                  serviceName:serviceTextCtrl.text,
                  serviceId: selectServiceId.value,
                  location: addressTextCtrl.text,
                  providerUid:_auth.currentUser!.uid,
                  averageRating: 0.0,
                  description:descriptionTextCtrl.text
              );
              await firebaseStorage.collection(AppConstants.services).doc(id).set(body.toJson());
              Get.snackbar("Success", "Service Added Successful");
              await serviceController.getService();
              serviceTextCtrl.clear();
              selectServiceId.value="";
              addressTextCtrl.clear();
              descriptionTextCtrl.clear();
              imagePath.value="";
              selectedItem.value=(-1);
            }else{
              Get.snackbar("Error","This Service Already Added");
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