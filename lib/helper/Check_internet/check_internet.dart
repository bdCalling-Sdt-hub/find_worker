import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wocontacts/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  // ignore: unused_field
  late ConnectivityResult _connectivityResult;
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    _initConnectivity();

  }

  Future<void> _initConnectivity() async {
    _connectivityResult = await _connectivity.checkConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (kDebugMode) print("STATUS : $connectivityResult");

    if (connectivityResult == ConnectivityResult.none) {



      Fluttertoast.showToast(msg:AppStrings.pleaseConnectToTheInternet.tr,toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.BOTTOM,);
      // Get.rawSnackbar(
      //     messageText: Text(AppStrings.pleaseConnectToTheInternet.tr,
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 14,
      //             fontWeight: FontWeight.w600)),
      //     isDismissible: false,
      //     duration: const Duration(days: 1),
      //     backgroundColor: Colors.red[400]!,
      //     icon: Icon(
      //       Icons.wifi_off,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //     margin: EdgeInsets.zero,
      //     snackPosition: SnackPosition.BOTTOM,
      //     snackStyle: SnackStyle.GROUNDED);
    } else {
      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}