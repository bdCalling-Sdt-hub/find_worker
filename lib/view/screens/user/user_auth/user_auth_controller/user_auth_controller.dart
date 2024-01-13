import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool isLoading = false;
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

  String phoneCode = "+93";

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

    // if (picked != null && picked != selectedDate && picked.isBefore(minimumAllowedDate)) {
    //   // The selected date is valid (not null, not equal to the current date, and at least 18 years ago)
    //     selectedDate = picked;
    //
    // } else {
    //
    // //  Fluttertoast.showToast(msg:"Invalid date selection.You must be at least 18 years old.");
    //
    //   print('Invalid date selection. You must be at least 18 years old.');
    // }
  }

  var sendOtpLoading = false.obs;
  var otpVerifyLoading = false.obs;

  // sendOtp(String userType) async {
  //   sendOtpLoading(true);
  //   var body = {"email": emailController.text};
  //   var response = await ApiService.sendOtpFunction(body);
  //   if (response.runtimeType != int) {
  //     Get.to(UserEmailOtpScreen(
  //       userType: userType,
  //     ));
  //   } else {
  //     Fluttertoast.showToast(msg: "Oops, Something wrong!");
  //   }
  //   sendOtpLoading(false);
  // }

  // reSendOtp() async {
  //   var body = {"email": emailController.text};
  //   var response = await ApiService.sendOtpFunction(body);
  //   if (response.runtimeType != int) {
  //     Fluttertoast.showToast(msg: "Resend Otp successfull");
  //   }
  // }

  // verifyOtp(String userType) async {
  //   otpVerifyLoading(true);

  //   var body = {"email": emailController.text, "otp": otpController.text};
  //   var response = await ApiService.otpVerifyFunction(body);
  //   if (response.runtimeType != int) {
  //     registerUser(userType);
  //     otpController.clear();
  //   } else {
  //     Fluttertoast.showToast(msg: "Invalid OTP");
  //   }
  //   otpVerifyLoading(false);
  // }

  // Future<void> registerUser(String userType) async {
  //   try {
  //     update();
  //     await auth
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text.trim(),
  //             password: passController.text.trim())
  //         .then((value) async {
  //       print("====>sign up");
  //       await postDetailsToFireStore(userType);
  //     });
  //     update();
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       Fluttertoast.showToast(
  //           msg: e.message!,
  //           backgroundColor: AppColors.blue_100,
  //           textColor: AppColors.white,
  //           fontSize: 14,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM);
  //     } else if (e.code == 'email-already-in-use') {
  //       Fluttertoast.showToast(
  //           msg: e.message!,
  //           backgroundColor: AppColors.blue_100,
  //           textColor: AppColors.white,
  //           fontSize: 14,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM);
  //       print('The account already exists for that email.');
  //     } else {
  //       print('Error during sign up: ${e.message}');
  //     }
  //   } on Exception catch (e) {
  //     print('Error during sign up: ${e}');
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }

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

  moreSignUpToFireStore(
      {required String uid,
      required String image,
      required String type}) async {
    loading(true);

    await fcmToken();

    UserModel userModel = UserModel();
    userModel.email = emailController.text;
    userModel.uid = uid;
    userModel.userName = nameController.text.toString();
    userModel.dob = selectedDate;
    // userModel.dob = DateTime(int.parse(yearController.text),
    //     int.parse(monthController.text), int.parse(dayController.text));
    userModel.phone = phoneController.text.toString();
    userModel.address = addressController.text.toString();
    userModel.authType = AppConstants.socialMediaUser;
    userModel.role = type;
    //userModel.password = passController.text;
    userModel.timestamp = DateTime.now();
    userModel.status = "Online";
    userModel.imageSrc = image;
    userModel.averageRating = 0.0;
    userModel.fcmToken = token;
    userModel.phoneCode = phoneCode;
    userModel.gender = genderList[selectedGender];
    try {
      await firebaseFireStore
          .collection(AppConstants.users)
          .doc(uid)
          .set(userModel.toMap())
          .then((value) {
        Fluttertoast.showToast(
            msg: "Account created successfully",
            backgroundColor: AppColors.blue_100,
            textColor: AppColors.black_100,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        PrefsHelper.setString(AppConstants.logged, type);
        nameController.clear();
        dayController.clear();
        monthController.clear();
        yearController.clear();
        selectedGender = 0;
        emailController.clear();
        phoneController.clear();
        addressController.clear();

        if (type == AppConstants.userType) {
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0),
              binding: UserBottomNavBinding());
        } else {
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0),
              binding: ProviderBottomNavBinding());
        }
      });
    } on Exception catch (e) {
      debugPrint("=====> Sign up catch error fire store $e");
    } finally {
      loading(false);
    }
  }

  // void loginUser(String email, String password, String userType) async {
  //   isLoading = true;
  //   update();

  //   try {
  //     await auth
  //         .signInWithEmailAndPassword(
  //             email: email.trim(), password: password.trim())
  //         .then((value) async {
  //       usernameController.clear();
  //       passwordController.clear();
  //       DocumentSnapshot data = await firebaseFireStore
  //           .collection(AppConstants.users)
  //           .doc(value.user!.uid)
  //           .get();

  //       if (data.exists) {
  //         UserModel userData = UserModel.fromMap(data);
  //         if (userData.role == userType) {
  //           debugPrint("=======> Uid ${data['uid']}");
  //           debugPrint("=======> User Type ${userData.role} and $userType");
  //           await PrefsHelper.setString(AppConstants.logged, userData.role);
  //           _dataController.setData(
  //               userNameD: userData.userName!,
  //               userRoleD: userData.role!,
  //               uidD: userData.uid!,
  //               imageD: userData.imageSrc!,
  //               authTypeD: userData.authType!);

  //           if (userData.role == AppConstants.userType) {
  //             Get.offAll(UserBottomNavBarScreen(currentIndex: 0),
  //                 binding: UserBottomNavBinding());
  //           } else {
  //             Get.offAll(SpBottomNavBarScreen(currentIndex: 0),
  //                 binding: ProviderBottomNavBinding());
  //           }
  //         } else {
  //           Get.snackbar("Error", "User not found", colorText: Colors.red);
  //         }
  //       }

  //       // Fluttertoast.showToast(
  //       //     msg: "Login Successfully",
  //       //     backgroundColor: AppColors.blue_100,
  //       //     textColor: AppColors.black_100,
  //       //     fontSize: 14,
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.BOTTOM
  //       // );
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Fluttertoast.showToast(
  //           msg: e.message!,
  //           backgroundColor: AppColors.blue_100,
  //           textColor: AppColors.white,
  //           fontSize: 14,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM);
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       Fluttertoast.showToast(
  //           msg: e.message!,
  //           backgroundColor: AppColors.blue_100,
  //           textColor: AppColors.white,
  //           fontSize: 14,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM);
  //       print('Wrong password provided for that user.');
  //     } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
  //       Fluttertoast.showToast(
  //           msg: "Oops, user not found!".tr,
  //           backgroundColor: AppColors.blue_100,
  //           textColor: AppColors.white,
  //           fontSize: 14,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM);
  //     } else {
  //       print('Error during sign in: ${e.message}');
  //       Fluttertoast.showToast(
  //           msg: e.message!,
  //           backgroundColor: AppColors.blue_100,
  //           textColor: AppColors.white,
  //           fontSize: 14,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM);
  //     }
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }

//Log in User with Phone Number

  void phoneCredentail(
      {required String userType, required bool isSignIn}) async {
    print("===================$phoneCode${phoneController.text}");
    await FirebaseAuth.instance
        .verifyPhoneNumber(
          
      phoneNumber: "$phoneCode${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        getVerificationId = verificationId;

        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      
    )
        .then((value) {
      Get.toNamed(AppRoute.userOtpScreen, arguments: [userType, isSignIn]);
    });
  }

  String getVerificationId = "";

  void loginWithPhoneGenerateOTP(
      {required String userType, required bool isSignIn}) async {
    var userData = await firebaseFireStore
        .collection(AppConstants.users)
        .where("phone", isEqualTo: phoneController.text)
        .get();

//Check if user has Signed In
    if (isSignIn) {
      if (userData.docs.isNotEmpty) {
        phoneCredentail(userType: userType, isSignIn: isSignIn);
      } else {
        Fluttertoast.showToast(msg: "You dont have any account Sign up");
      }
    }
//Check if user has Sign up
    else {
      if (userData.docs.isEmpty) {
        phoneCredentail(userType: userType, isSignIn: isSignIn);
      } else {
        Fluttertoast.showToast(
            msg: "You have already created an account Sign up");
      }
    }
  }

  void varifyPhoneOTP(
      {required String smsCode,
      required String userType,
      required bool isSignIn}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: getVerificationId, smsCode: smsCode);

    //
    UserCredential userCredential = await auth.signInWithCredential(credential);

    if (userCredential.user != null) {
      if (isSignIn) {
        await PrefsHelper.setString(AppConstants.logged, userType);
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
      } else {
        postDetailsToFireStore(userType);
      }
    }
  }

  // Future<void> signInWithGoogle(String userType) async {
  //   // Trigger the authentication flow
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     if (googleAuth != null) {
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       UserCredential userData =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       print("=======> Google Sign in Complete ");
  //       if (userData.user != null) {
  //         DocumentSnapshot data = await FirebaseFirestore.instance
  //             .collection(AppConstants.users)
  //             .doc(userData.user!.uid)
  //             .get();
  //         if (data.exists) {
  //           UserModel userData = UserModel.fromMap(data);
  //           debugPrint("=======> Uid ${data['uid']}");
  //           debugPrint("=======> User Type ${userData.role}");
  //           if (userData.role == userType) {
  //             await PrefsHelper.setString(AppConstants.logged, userData.role);
  //             if (userData.role == AppConstants.userType) {
  //               Get.offAll(UserBottomNavBarScreen(currentIndex: 0),
  //                   binding: UserBottomNavBinding());
  //               _dataController.setData(
  //                   userNameD: userData.userName!,
  //                   userRoleD: userData.role!,
  //                   uidD: userData.uid!,
  //                   imageD: userData.imageSrc!,
  //                   authTypeD: userData.authType!);
  //               usernameController.clear();
  //               passwordController.clear();
  //             } else {
  //               Get.offAll(SpBottomNavBarScreen(currentIndex: 0),
  //                   binding: ProviderBottomNavBinding());
  //               _dataController.setData(
  //                   userNameD: userData.userName!,
  //                   userRoleD: userData.role!,
  //                   uidD: userData.uid!,
  //                   imageD: userData.imageSrc!,
  //                   authTypeD: userData.authType!);
  //               usernameController.clear();
  //               passwordController.clear();
  //             }
  //           } else {
  //             Fluttertoast.showToast(msg: "User not found");
  //           }
  //         } else {
  //           Get.to(MoreSignUpScreen(
  //               uid: userData.user!.uid,
  //               email: userData.user!.email ?? "",
  //               image: userData.user!.photoURL ?? "",
  //               name: userData.user!.displayName ?? "",
  //               userType: userType));
  //         }
  //       }
  //     }
  //   } on Exception catch (e) {
  //     debugPrint("Oops, Something wrong error $e");
  //   }
  // }

  // Future<void> appleInWithGoogle(String userType) async {
  //   // Trigger the authentication flow
  //   try {
  //     final authProvider = AppleAuthProvider();

  //     UserCredential userData =
  //         await FirebaseAuth.instance.signInWithProvider(authProvider);
  //     if (userData.user != null) {
  //       print("=======> Apple Sign in Complete ");
  //       DocumentSnapshot data = await FirebaseFirestore.instance
  //           .collection(AppConstants.users)
  //           .doc(userData.user!.uid)
  //           .get();
  //       if (data.exists) {
  //         UserModel userData = UserModel.fromMap(data);
  //         debugPrint("=======> Uid ${data['uid']}");
  //         debugPrint("=======> User Type ${userData.role}");
  //         if (userData.role == userType) {
  //           await PrefsHelper.setString(AppConstants.logged, userData.role);
  //           if (userData.role == AppConstants.userType) {
  //             Get.offAll(
  //               UserBottomNavBarScreen(currentIndex: 0),
  //               binding: UserBottomNavBinding(),
  //             );
  //             _dataController.setData(
  //                 userNameD: userData.userName!,
  //                 userRoleD: userData.role!,
  //                 uidD: userData.uid!,
  //                 imageD: userData.imageSrc!,
  //                 authTypeD: userData.authType!);
  //             usernameController.clear();
  //             passwordController.clear();
  //           } else {
  //             Get.offAll(SpBottomNavBarScreen(currentIndex: 0),
  //                 binding: ProviderBottomNavBinding());
  //             _dataController.setData(
  //                 userNameD: userData.userName!,
  //                 userRoleD: userData.role!,
  //                 uidD: userData.uid!,
  //                 imageD: userData.imageSrc!,
  //                 authTypeD: userData.authType!);
  //             usernameController.clear();
  //             passwordController.clear();
  //           }
  //         } else {
  //           Fluttertoast.showToast(msg: "User not found");
  //         }
  //       } else {
  //         Get.to(MoreSignUpScreen(
  //             uid: userData.user!.uid,
  //             email: userData.user!.email ?? "",
  //             image: userData.user!.photoURL ?? "",
  //             name: userData.user!.displayName ?? "",
  //             userType: userType));
  //       }
  //     }
  //   } on Exception catch (e) {
  //     debugPrint("Oops, Something wrong error $e");
  //   }
  // }

  ///  <------------- Sign out------------->
  var isSignOutLoad = false.obs;
  final LocalizationController localizationController =
      Get.find<LocalizationController>();
  signOut(String type) async {
    try {
      isSignOutLoad(true);
      await auth.signOut().then((value) async {
        localizationController.setLanguage(Locale('en', "US"));
        Get.back();
        Get.offAll(() => const OnboardScreen());
        await PrefsHelper.setString(AppConstants.logged, "");
        debugPrint("=========> Successful sign out");
        isSignOutLoad(false);
      });
      await GoogleSignIn().signOut();
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
    if (auth.currentUser!.email == accountDeleteCtrl.text) {
      await auth.currentUser!.delete().then((value) async {
        localizationController.setLanguage(Locale('en', "US"));
        accountDeleteCtrl.clear();
        await PrefsHelper.setString(AppConstants.logged, "");
        await GoogleSignIn().signOut();
        Get.back();
        Get.offAll(() => const OnboardScreen());
        Fluttertoast.showToast(msg: AppStrings.accountDelete.tr);
        isAccountDeleteLoading(false);
      }).catchError((v) {
        Fluttertoast.showToast(msg: v.toString());
      });
      isAccountDeleteLoading(false);
    } else {
      Fluttertoast.showToast(msg: "Email Not matching");
      isAccountDeleteLoading(false);
    }
  }

  @override
  void dispose() {
    accountDeleteCtrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
