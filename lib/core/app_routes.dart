


import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_forget_password/user_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_otp/user_otp_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_reset_password/user_reset_password_screen.dart';
import 'package:get/get.dart';
class AppRoute {
   static String splashScreen = "/splash_screen";
   static String userForgetPasswordScreen = "/user_forget_password_screen";
   static String userOtpScreen = "/user_otp_screen";
   static String userResetPasswordScreen = "/user_reset_password_screen";


  static List<GetPage> routes = [
     GetPage(name: splashScreen, page: () => const SplashScreen()),
     GetPage(name: userForgetPasswordScreen, page: () => const UserForgetPasswordScreen()),
     GetPage(name: userOtpScreen, page: () => const UserOtpScreen()),
     GetPage(name: userResetPasswordScreen, page: () => const UserResetPasswordScreen()),
  ];
}