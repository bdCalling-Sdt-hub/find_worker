
import 'package:find_worker/view/screens/onboard/onboard_screen.dart';
import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:find_worker/view/screens/user/user_sign_in/user_sign_in_screen.dart';
import 'package:find_worker/view/screens/user/user_sign_up/user_sign_up_screen.dart';
import 'package:get/get.dart';
class AppRoute {
   static String splashScreen = "/splash_screen";
   static String onboardScreen = "/onboard_screen";
   static String userSignIn = "/user_sign_in_screen";
   static String userSignUp = "/user_sign_up_screen";

  static List<GetPage> routes = [
     GetPage(name: splashScreen, page: () => const SplashScreen()),
     GetPage(name: onboardScreen, page: () => const OnboardScreen()),
     GetPage(name: userSignIn, page: () => const UserSignIn()),
     GetPage(name: userSignUp, page: () => const UserSignUpScreen()),
  ];
}