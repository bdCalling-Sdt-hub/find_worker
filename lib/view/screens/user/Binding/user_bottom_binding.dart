import 'package:get/get.dart';

import '../category/Controller/category_controller.dart';
import '../home/Controller/home_controller.dart';
import '../user_profile/Controller/profile_controller.dart';

class UserBottomNavBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(UserHomeController());
    Get.put(CategoryController());
    Get.put(UserProfileController());
  }
}