
import 'package:find_worker/view/screens/onboard/onboard_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_add_new_service/sp_add_new_service_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_forget_password/sp_forget_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_otp/sp_otp_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_reset_password/sp_reset_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_sign_in/sp_sign_in_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_sign_up/sp_sign_up_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_verify_email_otp/sp_verify_email_otp_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/sp_home_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_details/sp_job_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_history_job_details/sp_history_job_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_history/sp_job_history/sp_job_history_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_notification/sp_notification_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_personal_information/sp_edit_personal_information/sp_edit_personal_information_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_personal_information/sp_personal_information/sp_personal_information_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/inner_widgets/sp_profile_log_out_alert.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_service_details/sp_edit_service_details/sp_edit_service_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_service_details/sp_service_details/sp_service_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_about_us/sp_about_us_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_forget_password/sp_change_forget_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_otp/sp_change_otp_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_password/sp_change_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_change_reset_password/sp_change_reset_password_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_privacy_policy/sp_privacy_policy_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_setting/sp_setting_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_support/sp_support_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_settings/sp_terms_of_conditions/sp_terms_of_conditions_screen.dart';
import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:find_worker/view/screens/user/category/category_screen.dart';
import 'package:find_worker/view/screens/user/home/car_wash_details/category_by_services_screen.dart';
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
import 'package:find_worker/view/screens/user/user_auth/user_email_otp/user_email_otp_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_forget_password/user_forget_password_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_otp/user_otp_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_reset_password/user_reset_password_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_sign_in/user_sign_in_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_sign_up/user_sign_up_screen.dart';
import 'package:find_worker/view/screens/user/user_hire_list/user_hire_details/user_hire_details_screen.dart';
import 'package:find_worker/view/screens/user/user_hire_list/user_hire_list/user_hire_list_screen.dart';
import 'package:find_worker/view/screens/user/user_history/user_history/user_history_screen.dart';
import 'package:find_worker/view/screens/user/user_history/user_history_details/user_history_details_screen.dart';
import 'package:find_worker/view/screens/user/user_notification/user_notification_screen.dart';
import 'package:find_worker/view/screens/user/user_personal_information/user_edit_personal-information/user_edit_personal-information_screen.dart';
import 'package:find_worker/view/screens/user/user_personal_information/user_personal_information/user_personal_information_screen.dart';
import 'package:find_worker/view/screens/user/user_profile/user_profile_screen.dart';
import 'package:find_worker/view/screens/user/user_service_details/user_service_details_screen.dart';
import 'package:get/get.dart';


class AppRoute {
   static String splashScreen = "/splash_screen";
   static String onboardScreen = "/onboard_screen";
   static String userSignIn = "/user_sign_in_screen";
   static String userSignUp = "/user_sign_up_screen";
   static String userEmailOtpScreen = "/user_email_otp_screen";
   static String userNotificationScreen = "/user_notification_screen";
   static String userProfileScreen = "/user_profile_screen";
   static String userPersonalInformationScreen = "/user_personal_information_screen";
   static String userEditPersonalInformationScreen = "/user_edit_personal_information_screen";
   static String userHireList = "/user_hire_list_screen";
   static String userHistoryScreen = "/user_history_screen";
   static String userServiceDetailsScreen = "/user_service_details_screen";
   static String spSignInScreen = "/sp_sign_in_screen";
   static String spSignUpScreen = "/sp_sign_up_screen";
   static String spVerifyEmailOtpScreen = "/sp_verify_email_otp_screen";
   static String spJobDetailsScreen = "/sp_job_details_screen";
   static String spNotificationScreen = "/sp_notification_screen";
   static String spProfileScreen = "/sp_profile_screen";
   static String spPersonalInformationScreen = "/sp_personal_information_screen";
   static String spEditPersonalInformationScreen = "/sp_edit_personal_information_screen";
   static String spServiceDetailsScreen = "/sp_service_details_screen";
   //static String spEditServiceDetailsScreen = "/sp_edit_service_details_screen";
   static String spAddNewServiceScreen = "/sp_add_new_service_screen";
   static String spHomeScreen = "/sp_home_screen";

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
     GetPage(name: splashScreen, page: () => const SplashScreen()),
     GetPage(name: onboardScreen, page: () => const OnboardScreen()),
     GetPage(name: userSignIn, page: () => const UserSignIn()),
     GetPage(name: userSignUp, page: () => const UserSignUpScreen()),
     GetPage(name: userEmailOtpScreen, page: () => const UserEmailOtpScreen()),
     GetPage(name: userNotificationScreen, page: () => const UserNotificationScreen()),
     GetPage(name: userProfileScreen, page: () => const UserProfileScreen()),
     GetPage(name: userPersonalInformationScreen, page: () => const UserPersonalInformationScreen()),
     GetPage(name: userEditPersonalInformationScreen, page: () => const UserEditPersonalInformation()),
     GetPage(name: userHireList, page: () => const UserHireListScreen()),

     GetPage(name: userHistoryScreen, page: () => const UserHistoryScreen()),
     GetPage(name: userServiceDetailsScreen, page: () => const UserServiceDetailsScreen()),
     GetPage(name: spSignInScreen, page: () => const SpSignInScreen()),
     GetPage(name: spSignUpScreen, page: () => const SpSignUpScreen()),
     GetPage(name: spVerifyEmailOtpScreen, page: () => const SpVerifyEmailOtpScreen()),
     GetPage(name: spJobDetailsScreen, page: () => const SpJobDetailsScreen()),
     GetPage(name: spNotificationScreen, page: () => const SpNotificationScreen()),
     GetPage(name: spProfileScreen, page: () => const SpProfileScreen()),
     GetPage(name: spPersonalInformationScreen, page: () => const SpPersonalInformationScreen()),
     GetPage(name: spEditPersonalInformationScreen, page: () => const SpEditPersonalInformationScreen()),
     GetPage(name: spServiceDetailsScreen, page: () => const SpServiceDetailsScreen()),
     // GetPage(name: spEditServiceDetailsScreen, page: () => const SpEditServiceScreen()),
     GetPage(name: spAddNewServiceScreen, page: () => const SpAddNewServiceScreen()),
     GetPage(name: spHomeScreen, page: () => const SpHomeScreen()),
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
     GetPage(name: homeScreen, page: () => HomeScreen()),
     GetPage(name: carWashDetailsScreen, page: () => const CategoryByServiceScreen()),
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