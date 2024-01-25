import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wrcontacts/controller/data_controller.dart';
import 'package:wrcontacts/core/app_routes.dart';
import 'package:wrcontacts/core/share_pre.dart';
import 'package:wrcontacts/helper/Language/language_controller.dart';
import 'package:wrcontacts/model/user_model.dart';
import 'package:wrcontacts/utils/app_colors.dart';
import 'package:wrcontacts/utils/app_constents.dart';
import 'package:wrcontacts/utils/app_strings.dart';
import 'package:wrcontacts/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:wrcontacts/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../onboard/onboard_screen.dart';
import '../../../service_provider/Binding/provider_bottombar_binding.dart';
import '../../Binding/user_bottom_binding.dart';

class AuthenticationController extends GetxController {
  final _dataController = Get.put(DataController());

  bool isObscure = true;
  RxBool isLoading = false.obs;
  bool rememberMe = false;

  final registerFormKey = GlobalKey<FormState>();

  final emailRegExP = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");

  int selectedIndex = 0;

  /// sign In
  final TextEditingController usernameController = TextEditingController();

  /// sign up
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String phoneCode = "+971";
  //String signUpPhoneCode = "+971";

  // Date TextFormField
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  List<String> genderList = ["Male", "Female", "Others"];
  int selectedGender = 0;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  /// forget

  /*late String email;
  late EmailOTP emailOTP;*/

  final TextEditingController otpController = TextEditingController();

  /// for firebase sign up
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime minimumAllowedDate =
        currentDate.subtract(Duration(days: 365 * 18));

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: minimumAllowedDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );

    if (picked != null) {
      selectedDate = picked;
      dobController.text =
          "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
    }


  }

  var sendOtpLoading = false.obs;
  var otpVerifyLoading = false.obs;


  /// added user info in firebase fire store
  var token = "";
  fcmToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  postDetailsToFireStore(String userType) async {
    await fcmToken();
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = emailController.text;
    userModel.uid = user!.uid;
    userModel.userName = nameController.text.toString();
    userModel.dob = selectedDate;
    // userModel.dob = DateTime(int.parse(yearController.text),
    //     int.parse(monthController.text), int.parse(dayController.text));
    userModel.phone = phoneController.text.toString();
    userModel.address = addressController.text.toString();
    userModel.authType = AppConstants.normalUser;
    userModel.role = userType;
    //userModel.password = passController.text;
    userModel.timestamp = DateTime.now();
    userModel.status = "Online";
    userModel.imageSrc = "";
    userModel.averageRating = 0.0;
    userModel.fcmToken = token;
    userModel.phoneCode = phoneCode;
    userModel.gender = genderList[selectedGender];
    await PrefsHelper.setString(AppConstants.userId, user.uid);
    try {
      await firebaseFireStore
          .collection(AppConstants.users)
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) {
        Fluttertoast.showToast(
            msg: "Account created successfully",
            backgroundColor: AppColors.blue_100,
            textColor: AppColors.black_100,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        PrefsHelper.setString(AppConstants.logged, userType);
        nameController.clear();
        dayController.clear();
        monthController.clear();
        yearController.clear();
        selectedGender = 0;
        emailController.clear();
        phoneController.clear();
        addressController.clear();

        debugPrint("Account Create and verification completed");
        if (userType == AppConstants.userType) {
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0),
              binding: UserBottomNavBinding());
        } else {
          Get.offAll(
              SpBottomNavBarScreen(
                currentIndex: 0,
              ),
              binding: ProviderBottomNavBinding());
        }
      });
    } on Exception catch (e) {
      debugPrint("=====> Sign up catch error fire store $e");
    }
  }

  var loading = false.obs;

  String getVerificationId = "";


  Future phoneCredentail(
      {required String userType, required bool isSignIn}) async {
    print("===================$phoneCode${phoneController.text}");
    await auth.setSettings(appVerificationDisabledForTesting: true);
    await auth
        .verifyPhoneNumber(
      phoneNumber: "$phoneCode${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          Fluttertoast.showToast(msg:"The provided phone number is not valid.",toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.TOP);
        }
        print('Verification failed: ${e.message}');

      },
      codeSent: (String verificationId, int? resendToken) {
        getVerificationId = verificationId;
        update();
        Get.toNamed(AppRoute.userOtpScreen, arguments: [userType, isSignIn]);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

  }

  var resendOtpLoading=false;

  Future<void> resendOtp() async {
    try {
      resendOtpLoading=true;
      update();
      await auth.verifyPhoneNumber(
        phoneNumber:"$phoneCode${phoneController.text}",
        codeSent: (String verificationId, int? resendToken) {
          getVerificationId=verificationId;
          Fluttertoast.showToast(msg:"Resend Otp Successful",toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.TOP);

        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            Fluttertoast.showToast(msg:"The provided phone number is not valid.",toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.TOP);
          }
          print('Verification failed: ${e.message}');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Called when the auto-retrieval of the verification code has timed out
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        },
      );
    } finally {
      resendOtpLoading=false;
      update();
    }

  }



  void loginWithPhoneGenerateOTP(
      {required String userType, required bool isSignIn}) async {
    try {
      isLoading(true);
      update();
      debugPrint("Phone Number Sign in : ${phoneController.text}");

      var userData = await firebaseFireStore
          .collection(AppConstants.users)
          .where("phone", isEqualTo: phoneController.text)
          .get();

      //Check if user has Signed In
      if (isSignIn) {

        if (userData.docs.isNotEmpty) {
          var data=userData.docs.first.data();
          if(data['role']==userType){
          await  phoneCredentail(userType: userType, isSignIn: isSignIn);
          }else{
            Fluttertoast.showToast(msg: "You have already created a ${data['role'].toLowerCase()} account");
          }

        } else {
          Fluttertoast.showToast(msg: "You don't have any account sign up");
        }
      }
      //Check if user has Sign up
      else {
        if (userData.docs.isEmpty) {
        await  phoneCredentail(userType: userType, isSignIn: isSignIn);
        isLoading(false);
        } else {
          Fluttertoast.showToast(
              msg: "You have already created an account Sign in");
        }
      }
    } finally {
      isLoading(false);
      update();
    }

  }


  var verifyPhoneOtpLoading=false;


  void verifyPhoneOTP(
      {required String smsCode,
      required String userType,
      required bool isSignIn}) async {
    try {
      verifyPhoneOtpLoading = true;
      update();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: getVerificationId, smsCode: smsCode);

      //
      UserCredential userCredential = await auth.signInWithCredential(credential);

      debugPrint("=====> user id : ${userCredential.user!.uid}");

      if (userCredential.user != null) {
        await PrefsHelper.setString(AppConstants.userId, userCredential.user!.uid);
        if (isSignIn) {
          await PrefsHelper.setString(AppConstants.logged, userType);
          if (userType == AppConstants.userType) {
            Get.offAll(UserBottomNavBarScreen(currentIndex: 0),
                binding: UserBottomNavBinding());
            phoneCode="+971";
            phoneController.clear();
          } else {
            Get.offAll(
                SpBottomNavBarScreen(
                  currentIndex: 0,
                ),
                binding: ProviderBottomNavBinding());
            phoneCode="+971";
            phoneController.clear();
          }
        } else {
          postDetailsToFireStore(userType);
        }
      }
    } catch (e){
      if (e is FirebaseAuthException) {
        // Handle specific error codes
        if (e.code == 'invalid-verification-code') {
          // Incorrect OTP entered
          Fluttertoast.showToast(
              msg: "Incorrect OTP entered. Please try again.");
          print("Incorrect OTP entered. Please try again.");

        } else {
          // Other FirebaseAuthException, handle accordingly
          print("Error signing in: ${e.message}");
        }
      } else {
        // Handle other exceptions
        print("Error signing in: $e");
      }
    } finally {
      verifyPhoneOtpLoading = false;
      update();
    }


  }

  ///  <------------- Sign out------------->
  var isSignOutLoad = false.obs;
  final LocalizationController localizationController =
      Get.find<LocalizationController>();
  signOut(String type) async {
    try {
      isSignOutLoad(true);
      await auth.signOut().then((value) async {
        localizationController.setLanguage(Locale('en', "US"));
        localizationController.setSelectIndex(0);
        Get.back();
        Get.offAll(() => const OnboardScreen());
        await PrefsHelper.setString(AppConstants.logged, "");

        await PrefsHelper.setInt(AppConstants.adsCount, (-1));
        debugPrint("=========> Successful sign out");
        isSignOutLoad(false);
      });
    } on Exception catch (e) {
      debugPrint("=========> sign out catch error : $e");
    } finally {
      isSignOutLoad(false);
    }
  }

  ///  <------------- Account Delete ------------->
  var isAccountDeleteLoading = false.obs;
  TextEditingController accountDeleteCtrl = TextEditingController();
  deleteController() async {
    isAccountDeleteLoading(true);
    if (auth.currentUser!.phoneNumber == accountDeleteCtrl.text) {
      await auth.currentUser!.delete().then((value) async {
        localizationController.setLanguage(const Locale('en', "US"));
        localizationController.setSelectIndex(0);
        accountDeleteCtrl.clear();
        await PrefsHelper.setString(AppConstants.logged, "");
        await PrefsHelper.setInt(AppConstants.adsCount, (-1));
        Get.back();
        Get.offAll(() => const OnboardScreen());

        Fluttertoast.showToast(msg: AppStrings.accountDelete.tr);
        isAccountDeleteLoading(false);
      }).catchError((v) {
        Fluttertoast.showToast(msg: v.toString());
      });
      isAccountDeleteLoading(false);
    } else {
      Fluttertoast.showToast(msg: "Phone number not matching");
      isAccountDeleteLoading(false);
    }
  }


  // var testVId="";
  //
  //
  // Future<void> verifyPhoneNumber() async {
  //   debugPrint("$phoneCode${phoneController.text}");
  //   try {
  //
  //     await auth.verifyPhoneNumber(
  //       phoneNumber:"$phoneCode${phoneController.text}",
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         if (e.code == 'invalid-phone-number') {
  //           print('The provided phone number is not valid.');
  //         }
  //         print('Verification failed: ${e.message}');
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         print('Code sent to ${phoneController.text}');
  //
  //           testVId = verificationId;
  //
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         print('Auto retrieval timeout');
  //       },
  //     );
  //   } catch (e) {
  //     print('Error verifying phone number: $e');
  //   }
  // }
  //


  @override
  void dispose() {
    accountDeleteCtrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
