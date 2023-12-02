
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../sp_home/Controller/home_controller.dart';
import '../sp_job_history/Controller/sp_history_controller.dart';
import '../sp_profile/Controller/profile_controller.dart';



class ProviderBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpHomeController());
    Get.put(SpProfileController());
    Get.put(SpHistoryController());
  }
}