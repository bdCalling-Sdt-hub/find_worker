
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_forget_password/sp_forget_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_otp/sp_otp_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_reset_password/sp_reset_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_history_job_details/sp_history_job_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_about_us/sp_about_us_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_forget_password/sp_change_forget_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_otp/sp_change_otp_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_password/sp_change_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_reset_password/sp_change_reset_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_privacy_policy/sp_privacy_policy_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_setting/sp_setting_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_support/sp_support_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_terms_of_conditions/sp_terms_of_conditions_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_forget_password/user_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_otp/user_otp_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_reset_password/user_reset_password_screen.dart';
import 'package:find_worker/view/screens/user/category/category_screen.dart';
import 'package:find_worker/view/screens/user/home/car_wash_details/car_wash_details_screen.dart';
import 'package:find_worker/view/screens/user/home/home/home_screen.dart';
import 'package:find_worker/view/screens/user/search/search_screen.dart';
import 'package:find_worker/view/screens/user/settings/about_us/about_us_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_forget_password/change_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_otp/change_otp_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_password/change_password_screen.dart';
import 'package:find_worker/view/screens/user/settings/change_reset_password/change_reset_password_screen.dart';
import 'package:find_worker/view/screens/user/settings/privacy_policy/privacy_policy_screen.dart';
import 'package:find_worker/view/screens/user/settings/settings/settings_screen.dart';
import 'package:find_worker/view/screens/user/settings/support/support_screen.dart';
import 'package:find_worker/view/screens/user/settings/terms_of_conditions/terms_of_conditions_screen.dart';
import 'package:get/get.dart';


class AppRoute {

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
   static String homeScreen = "/home_screen";
   static String carWashDetailsScreen = "/car_wash_details_screen";
   static String categoryScreen = "/category_screen";
   static String searchScreen = "/search_screen";
   static String spAboutUsScreen = "/sp_about_us_screen";
   static String spChangeForgetPasswordScreen = "/sp_change_forget_password_screen";
   static String spChangeOtpScreen = "/sp_change_otp_screen";
   static String spChangePasswordScreen = "/sp_change_password_screen";
   static String spChangeResetPasswordScreen = "/sp_change_reset_password_screen";
   static String spPrivacyPolicyScreen = "/sp_privacy_policy_screen";
   static String spSettingScreen = "/sp_setting_screen";
   static String spSupportScreen = "/sp_support_screen";
   static String spTermsOfConditionsScreen = "/sp_terms_of_conditions_screen";
   static String spJobHistoryScreen = "/sp_job_history_screen";
   static String spHistoryDetailsScreen = "/sp_history_job_details_screen";
   static String spForgetPasswordScreen = "/sp_forget_password_screen";
   static String spOtpScreen = "/sp_otp_screen";
   static String spResetPasswordScreen = "/sp_reset_password_screen";


  static List<GetPage> routes = [

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
     GetPage(name: homeScreen, page: () => const HomeScreen()),
     GetPage(name: carWashDetailsScreen, page: () => const CarWashDetailsScreen()),
     GetPage(name: categoryScreen, page: () => const CategoryScreen()),
     GetPage(name: searchScreen, page: () => const SearchScreen()),
     GetPage(name: spAboutUsScreen, page: () => const SpAboutUsScreen()),
     GetPage(name: spChangeForgetPasswordScreen, page: () => const SpChangeForgetPasswordScreen()),
     GetPage(name: spChangeOtpScreen, page: () => const SpChangeOtpScreen()),
     GetPage(name: spChangePasswordScreen, page: () => const SpChangePasswordScreen()),
     GetPage(name: spChangeResetPasswordScreen, page: () => const SpChangeResetPasswordScreen()),
     GetPage(name: spPrivacyPolicyScreen, page: () => const SpPrivacyPolicyScreen()),
     GetPage(name: spSettingScreen, page: () => const SpSettingScreen()),
     GetPage(name: spSupportScreen, page: () => const SpSupportScreen()),
     GetPage(name: spTermsOfConditionsScreen, page: () => const SpTermsOfConditionsScreen()),
     GetPage(name: spJobHistoryScreen, page: () => const SpJobHistoryScreen()),
     GetPage(name: spHistoryDetailsScreen, page: () => const SpHistoryDetailsScreen()),
     GetPage(name: spForgetPasswordScreen, page: () => const SpForgetPasswordScreen()),
     GetPage(name: spOtpScreen, page: () => const SpOtpScreen()),
     GetPage(name: spResetPasswordScreen, page: () => const SpResetPasswordScreen()),
  ];
}