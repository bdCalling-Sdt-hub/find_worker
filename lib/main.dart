import 'package:country_code_picker/country_code_picker.dart';
import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/helper/Language/language_controller.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'helper/Language/dep.dart' as dep;
import 'firebase_options.dart';
import 'helper/Language/language_component.dart';
import 'helper/Language/massages.dart';
import 'helper/Notification/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Map<String, Map<String, String>> languages = await dep.init();
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {}
      await NotificationHelper.init(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(
          NotificationHelper.firebaseMessagingBackgroundHandler);
    }
    // ignore: empty_catches
  } catch (e) {}
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // navigation bar color
      statusBarColor: Colors.white, // status bar color
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp(
    languages: languages,
  ));
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.languages});

  Map<String, Map<String, String>> languages;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      // minTextAdapt: true,
      // splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetBuilder<LocalizationController>(
            builder: (localizationController) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // defaultTransition: Transition.noTransition,

            localizationsDelegates: const [
              CountryLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // arabic, no country code
            ],
            navigatorKey: Get.key,
            locale: localizationController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(LanguageComponent.languages[0].languageCode,
                LanguageComponent.languages[0].countryCode),
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: true,
                    titleTextStyle: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue_100),
                    iconTheme: const IconThemeData(
                      color: Color(0xFF0668E3),
                    ))),
            transitionDuration: const Duration(milliseconds: 200),
            getPages: AppRoute.routes,
            initialRoute: AppRoute.splashScreen,
          );
        });
      },
    );
  }
}
