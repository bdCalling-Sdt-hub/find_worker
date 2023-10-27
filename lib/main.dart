import 'package:find_worker/core/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      initialRoute: AppRoute.searchScreen,
      navigatorKey: Get.key,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: AppRoute.routes,
    );
  }
}