import 'package:device_preview/device_preview.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/helper/Language/language_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'helper/Language/dep.dart' as dep;
import 'firebase_options.dart';
import '';
import 'helper/Language/language_component.dart';
import 'helper/Language/massages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Map<String,Map<String,String>> languages= await dep.init();
  runApp( MyApp(languages: languages,));
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}
class MyApp extends StatelessWidget {
  MyApp({super.key,required this.languages});

  Map<String ,Map<String,String>> languages;
  @override
  Widget build(BuildContext context) {
 return   ScreenUtilInit(
      designSize: const Size(390, 844),
   //   minTextAdapt: true,
     // splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return  GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     // defaultTransition: Transition.noTransition,
      initialRoute: AppRoute.splashScreen,
      navigatorKey: Get.key,
                locale: localizationController.locale,
              translations: Messages(languages:languages),
             fallbackLocale:Locale(LanguageComponent.languages[0].languageCode,LanguageComponent.languages[0].countryCode),
      theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation:0,
              iconTheme: IconThemeData(
                color: Color(0xFF0668E3),
              )
            )
      ),

      transitionDuration: const Duration(milliseconds: 200),
      getPages: AppRoute.routes,


    );
          }
        );
      },
    );
  }
}