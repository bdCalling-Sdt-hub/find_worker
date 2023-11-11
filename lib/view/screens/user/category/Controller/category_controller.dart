import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../model/category_model.dart';
import '../../../../../utils/app_constents.dart';

class CategoryController extends GetxController{

  FirebaseFirestore  firebaseStorage= FirebaseFirestore.instance;
  RxList<CategoryModel> categoryList= <CategoryModel>[].obs;
  var loading=false.obs;
  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  getCategory()async{
    try {
      loading(true);
      var result= await  firebaseStorage.collection(AppConstants.category).get();
      categoryList.value= List<CategoryModel>.from(result.docs.map((x) => CategoryModel.fromJson(x)));
      debugPrint("========> CategoryLength = ${categoryList.length}");
      categoryList.refresh();
      loading(false);
    } on Exception catch (e) {
      print("=======> Opps error :$e");
    }finally{
      loading(false);
    }
  }









}