import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/model/category_model.dart';
import 'package:find_worker/model/service_by_user_model.dart';
import 'package:find_worker/model/service_model.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  @override
  void onInit() {
   getData();
    super.onInit();
  }
  FirebaseFirestore  firebaseStorage= FirebaseFirestore.instance;
   RxList<CategoryModel> categoryList= <CategoryModel>[].obs;
   var loading=false.obs;
  RxList<UserByServiceModel> carWashList= <UserByServiceModel> [].obs;
  RxList<UserByServiceModel> homeCleanList= <UserByServiceModel> [].obs;
  RxList<UserByServiceModel> airConditionList= <UserByServiceModel> [].obs;


getData()async{
   loading(true);
  await getCategory();
  await getSortedServicesByAverageRatingCarWash();
  await getSortedServicesByAverageRatingHomeClean();
  await getSortedServicesByAverageRatingAirCondition();
   loading(false);
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






  late DocumentSnapshot data;
  Future<DocumentSnapshot> getUser(String id) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(id)
        .get()
        .then((value) async {
      data = value;
    });
    return data;
  }



Future<List<UserByServiceModel>?> getSortedServicesByAverageRatingCarWash() async {
  final servicesCollection = FirebaseFirestore.instance.collection(AppConstants.services);
  final usersCollection = FirebaseFirestore.instance.collection(AppConstants.users);

  try {
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
    carWashList.value=sortedServices;
    return sortedServices;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
Future<List<UserByServiceModel>?> getSortedServicesByAverageRatingHomeClean() async {
  final servicesCollection = FirebaseFirestore.instance.collection(AppConstants.services);
  final usersCollection = FirebaseFirestore.instance.collection(AppConstants.users);

  try {
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
    homeCleanList.value=sortedServices;
    return sortedServices;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
Future<List<UserByServiceModel>?> getSortedServicesByAverageRatingAirCondition() async {
  final servicesCollection = FirebaseFirestore.instance.collection(AppConstants.services);
  final usersCollection = FirebaseFirestore.instance.collection(AppConstants.users);

  try {
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
    airConditionList.value=sortedServices;
    return sortedServices;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}




}