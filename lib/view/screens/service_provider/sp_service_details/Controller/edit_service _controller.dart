import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wrcontacts/model/category_model.dart';
import 'package:wrcontacts/model/service_model.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_services/Controller/service_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditServiceController extends GetxController{
   ServiceController serviceController=Get.put(ServiceController());

  RxList<CategoryModel> categoryList= <CategoryModel>[].obs;

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
  var uuid = Uuid();
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


  var updateServiceLoad=false.obs;
 Future<dynamic>  updateService(ServiceModel model)async{
    if(!updateServiceLoad.value){
      if(formKey.currentState!.validate()){
        updateServiceLoad(true);
        try {

            var url="";
            if(imagePath.isNotEmpty){
              url = await uploadImage(model.id!);
            }

            ServiceModel body=ServiceModel(
                image:imagePath.isNotEmpty?url:model.image!,
                id:model.id!,
                serviceName:serviceTextCtrl.text,
                serviceId: selectServiceId.value,
                location: addressTextCtrl.text,
                providerUid:model.providerUid,
                description:descriptionTextCtrl.text,
                  options: selectedOption.value
            );
            await firebaseStorage.collection(AppConstants.services).doc(model.id).update(body.toJson());
            await serviceController.getService();
            Fluttertoast.showToast(msg:"Service Update Successful");
            return body;
        } on Exception catch (e) {
          debugPrint("Add error. Reason ${e.toString()}");
          return 1;
          // TODO
        }finally{
          updateServiceLoad(false);

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