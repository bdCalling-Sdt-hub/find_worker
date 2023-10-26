
import 'package:find_worker/view/screens/onboard/onboard_screen.dart';
import 'package:find_worker/view/screens/splash/splash_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_email_otp/user_email_otp_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_sign_in/user_sign_in_screen.dart';
import 'package:find_worker/view/screens/user/auth/user_sign_up/user_sign_up_screen.dart';
import 'package:find_worker/view/screens/user/user_hire_list/user_hire_details/user_hire_details_screen.dart';
import 'package:find_worker/view/screens/user/user_hire_list/user_hire_list/user_hire_list_screen.dart';
import 'package:find_worker/view/screens/user/user_notification/user_notification_screen.dart';
import 'package:find_worker/view/screens/user/user_personal_information/user_edit_personal-information/user_edit_personal-information_screen.dart';
import 'package:find_worker/view/screens/user/user_personal_information/user_personal_information/user_personal_information_screen.dart';
import 'package:find_worker/view/screens/user/user_profile/user_profile_screen.dart';
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
  ];
}