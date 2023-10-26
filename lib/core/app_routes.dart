


import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_forget_password/user_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_otp/user_otp_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_reset_password/user_reset_password_screen.dart';
import 'package:find_worker/view/screens/user/home/home_screen.dart';
import 'package:find_worker/view/screens/user/notification/notification_screen.dart';
import 'package:find_worker/view/screens/user/settings/about_us/about_us_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_forget_password/change_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_otp/change_otp_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_password/change_password_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_reset_password/change_reset_password_screen.dart';
import 'package:find_worker/view/screens/user/settings/privacy_policy/privacy_policy_screen.dart';
import 'package:find_worker/view/screens/user/settings/settings/settings_screen.dart';
import 'package:find_worker/view/screens/user/settings/support/support_screen.dart';
import 'package:get/get.dart';

import '../view/screens/user/settings/terms_of_conditions/terms_of_conditions_screen.dart';
class AppRoute {
   static String splashScreen = "/splash_screen";
   static String userForgetPasswordScreen = "/user_forget_password_screen";
   static String userOtpScreen = "/user_otp_screen";
   static String userResetPasswordScreen = "/user_reset_password_screen";
   static String changePasswordScreen = "/change_password_screen";
   static String changeForgetPasswordScreen = "/change_forget_password_screen";
   static String changeOtpScreen = "/change_otp_screen";
   static String changeResetPasswordScreen = "/change_reset_password_screen";
   static String privacyPolicyScreen = "/privacy_policy_screen";
   static String settingScreen = "/settings_screen";
   static String termsOfConditionsScreen = "/terms_of_conditions_screen";
   static String aboutUsScreen = "/about_us_screen";
   static String supportScreen = "/support_screen";
   static String notificationScreen = "/notification_screen";
   static String homeScreen = "/home_screen";


  static List<GetPage> routes = [
     GetPage(name: splashScreen, page: () => const SplashScreen()),
     GetPage(name: userForgetPasswordScreen, page: () => const UserForgetPasswordScreen()),
     GetPage(name: userOtpScreen, page: () => const UserOtpScreen()),
     GetPage(name: userResetPasswordScreen, page: () => const UserResetPasswordScreen()),
     GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
     GetPage(name: changeForgetPasswordScreen, page: () => const ChangeForgetPasswordScreen()),
     GetPage(name: changeOtpScreen, page: () => const ChangeOtpScreen()),
     GetPage(name: changeResetPasswordScreen, page: () => const ChangeResetPasswordScreen()),
     GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
     GetPage(name: settingScreen, page: () => const SettingScreen()),
     GetPage(name: termsOfConditionsScreen, page: () => const TermsOfConditionsScreen()),
     GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),
     GetPage(name: supportScreen, page: () => const SupportScreen()),
     GetPage(name: notificationScreen, page: () => const NotificationScreen()),
     GetPage(name: homeScreen, page: () => const HomeScreen()),
  ];
}