import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/service_by_user_model.dart';
import '../../../../../utils/app_constents.dart';

class CategoryByServiceController extends GetxController {
  RxList<UserByServiceModel> servicesList = <UserByServiceModel>[].obs;
  var loading = false.obs;

  Future<List<UserByServiceModel>?> getSortedServicesByCategory(
      String catId) async {
    debugPrint("======>$catId");
    final servicesCollection = FirebaseFirestore.instance
        .collection(AppConstants.services)
        .where("category_id", isEqualTo: catId);
    final usersCollection =
        FirebaseFirestore.instance.collection(AppConstants.users);

    try {
      loading(true);
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
      sortedServices
          .sort((a, b) => b.averageRating!.compareTo(a.averageRating!));
      print("service list ========> ${sortedServices.length}");
      servicesList.value = sortedServices;
      servicesList.refresh();
      loading(false);
      return sortedServices;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
