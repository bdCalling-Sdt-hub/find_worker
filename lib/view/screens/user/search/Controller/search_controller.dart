import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/model/category_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../../../model/service_by_user_model.dart';

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
  RxString selectCategory="".obs;
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

  RxList<UserByServiceModel> servicesList= <UserByServiceModel> [].obs;
  var serviceLoading=true.obs;

  Future<List<UserByServiceModel>?> getSortedServicesByCategory(String catId) async {
    final servicesCollection = FirebaseFirestore.instance.collection(AppConstants.services).where("category_id",isEqualTo:catId);
    final usersCollection = FirebaseFirestore.instance.collection(AppConstants.users);

    try {
      serviceLoading(true);
      final servicesSnapshot = await servicesCollection.get();

      List<UserByServiceModel> sortedServices = [];


      for (final serviceDoc in servicesSnapshot.docs) {
        final serviceData = serviceDoc.data();
        final serviceProviderId = serviceData['provider_uid'];
        print("service id ========> ${serviceData['provider_uid']}");

        final userDoc = await usersCollection.doc(serviceProviderId).get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          final averageRating = userData!['average_rating'];
          final providerName = userData['username'];

          serviceData['average_rating'] = averageRating;
          serviceData['provider_name'] = providerName;
          sortedServices.add(UserByServiceModel.fromJson(serviceData));
        }
      }
      sortedServices.sort((a, b) => b.averageRating!.compareTo(a.averageRating!));
      print("service list ========> ${sortedServices.length}");
      servicesList.value=sortedServices;
      servicesList.refresh();
      serviceLoading(false);
      return sortedServices;
    } catch (e) {
      print('Error: $e');
      return null;
    }finally{
      serviceLoading(false);
    }
  }



}