
import 'package:find_worker/view/screens/onboard/onboard_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_add_new_service/sp_add_new_service_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_sign_in/sp_sign_in_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_sign_up/sp_sign_up_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_auth/sp_verify_email_otp/sp_verify_email_otp_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_job_details/sp_job_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_notification/sp_notification_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_personal_information/sp_edit_personal_information/sp_edit_personal_information_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_personal_information/sp_personal_information/sp_personal_information_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/inner_widgets/sp_profile_log_out_alert.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/sp_profile_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_service_details/sp_edit_service_details/sp_edit_service_details_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_service_details/sp_service_details/sp_service_details_screen.dart';
import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_email_otp/user_email_otp_screen.dart';
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
   static String userHireDetailsScreen = "/user_hire_details_screen";
   static String userHistoryScreen = "/user_history_screen";
   static String userHistoryDetailsScreen = "/user_history_details_screen";
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
   static String spEditServiceDetailsScreen = "/sp_edit_service_details_screen";
   static String spAddNewServiceScreen = "/sp_add_new_service_screen";

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
     GetPage(name: userHireDetailsScreen, page: () => const UserHireDetailsScreen()),
     GetPage(name: userHistoryScreen, page: () => const UserHistoryScreen()),
     GetPage(name: userHistoryDetailsScreen, page: () => const UserHistoryDetailsScreen()),
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
     GetPage(name: spEditServiceDetailsScreen, page: () => const SpEditServiceDetailsScreen()),
     GetPage(name: spAddNewServiceScreen, page: () => const SpAddNewServiceScreen()),
  ];
}