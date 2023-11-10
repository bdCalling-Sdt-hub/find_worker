import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/model/category_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class SearchAndFilterController extends GetxController{


  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

 FirebaseFirestore  firebaseStorage= FirebaseFirestore.instance;
   RxList<CategoryModel> categoryList= <CategoryModel>[].obs;
   var loading=false.obs;
    TextEditingController typeAheadController = TextEditingController();
  int selectCategory=(-1);
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();


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


  List<CategoryModel> getSuggestions(String query) {
    List<CategoryModel> matches = <CategoryModel>[];
    matches.addAll(categoryList);
    matches.retainWhere((s) => s.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



}