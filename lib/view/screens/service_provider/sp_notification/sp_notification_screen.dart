import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/utils/app_strings.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_history_job_details/sp_history_job_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_notification/Controller/notification_controller.dart';
import 'package:find_worker/view/widgets/app_bar/custom_app_bar.dart';
import 'package:find_worker/view/widgets/custom_loader.dart';
import 'package:find_worker/view/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_back.dart';
import '../sp_job_details/sp_job_details_screen.dart';

class SpNotificationScreen extends StatefulWidget {
  const SpNotificationScreen({super.key});

  @override
  State<SpNotificationScreen> createState() => _SpNotificationScreenState();
}

class _SpNotificationScreenState extends State<SpNotificationScreen> {
  final _notificationController = Get.put(SpNotificationController());

  @override
  void initState() {
    _notificationController.getNotification(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.notification.tr),
        leading:  CustomBack(),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(() => _notificationController.loading.value
            ? const CustomLoader()
            : _notificationController.notificationList.isEmpty
                ? Center(
                    child: Text(AppStrings.noDataAvailable.tr),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await _notificationController.getNotification(false);
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      itemBuilder: (BuildContext context, int index) {
                        var data =
                            _notificationController.notificationList[index];
                        return GestureDetector(
                          onTap: () {
                            if (data.status == AppConstants.complete ||
                                data.status == AppConstants.canceled) {
                              Get.to(SpJobHistoryDetailsScreen(
                                  jobId: data.historyId!));
                            } else {
                              Get.to(SpJobDetailsScreen(
                                jobId: data.historyId!,
                              ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.blue_60, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: data.content!,
                                  bottom: 8,
                                ),
                                Text(formatDate(data.createAt!))
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount:
                          _notificationController.notificationList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                    ),
                  ));
      }),
    );
  }

  String formatDate(DateTime dateTime) {
    // Format pattern for "Fri at 12:00 am"
    String pattern = 'E \'at\' hh:mm a';

    // Create a DateFormat object with the specified pattern
    DateFormat formatter = DateFormat(pattern);

    // Format the DateTime object
    String formattedDateTime = formatter.format(dateTime);

    return formattedDateTime;
  }
}
