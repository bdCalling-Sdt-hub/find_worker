
import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
class AppRoute {
   static String splashScreen = "/splash_screen";


  static List<GetPage> routes = [
     GetPage(name: splashScreen, page: () => const SplashScreen()),
  ];
}