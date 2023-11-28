import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:find_worker/controller/data_controller.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/core/share_pre.dart';
import 'package:find_worker/helper/Language/language_controller.dart';
import 'package:find_worker/model/user_model.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/screens/service_provider/sp_home/Controller/home_controller.dart';
import 'package:find_worker/view/screens/service_provider/sp_profile/Controller/profile_controller.dart';
import 'package:find_worker/view/screens/user/home/Controller/home_controller.dart';
import 'package:find_worker/view/screens/user/user_auth/user_sign_in/user_sign_in_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_sign_up/more_sign_up_screen.dart';
import 'package:find_worker/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../onboard/onboard_screen.dart';

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
  final TextEditingController passwordController = TextEditingController();

  /// sign up
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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

  Future<void> registerUser(String userType) async {
    isLoading = true;
    update();
    if (registerFormKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim())
          .then((value) async {
        print("====>sign up");
        await postDetailsToFireStore(userType);
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: e!.message,
            backgroundColor: AppColors.blue_100,
            textColor: AppColors.white,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        isLoading = false;
        update();
      });
    }
    isLoading = false;
    update();
  }

  /// added user info in firebase fire store
  var token = "";
  fcmToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  postDetailsToFireStore(String userType) async {
    await fcmToken();
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = nameController.text.toString();
    userModel.dob = DateTime(int.parse(yearController.text),
        int.parse(monthController.text), int.parse(dayController.text));
    userModel.phone = phoneController.text.toString();
    userModel.address = addressController.text.toString();
    userModel.authType = AppConstants.normalUser;
    userModel.role = userType;
    userModel.password = passController.text;
    userModel.timestamp = DateTime.now();
    userModel.status = "Online";
    userModel.imageSrc = "";
    userModel.averageRating = 0.0;
    userModel.fcmToken = token;
    userModel.phoneCode=phoneCode;
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
        passwordController.clear();
        confirmPasswordController.clear();
        if (userType == AppConstants.userType) {
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
        } else {
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
        }
      });
    } on Exception catch (e) {
      debugPrint("=====> Sign up catch error fire store $e");
    }
  }


var loading=false.obs;

  moreSignUpToFireStore({required String uid,required String image,required String type}) async {
      loading(true);
    
    await fcmToken();
    
    UserModel userModel = UserModel();
    userModel.email =emailController.text;
    userModel.uid = uid;
    userModel.userName = nameController.text.toString();
    userModel.dob = DateTime(int.parse(yearController.text),
        int.parse(monthController.text), int.parse(dayController.text));
    userModel.phone = phoneController.text.toString();
    userModel.address = addressController.text.toString();
    userModel.authType = AppConstants.socialMediaUser;
    userModel.role = type;
    userModel.password = passController.text;
    userModel.timestamp = DateTime.now();
    userModel.status = "Online";
    userModel.imageSrc = image;
    userModel.averageRating = 0.0;
    userModel.fcmToken = token;
    userModel.phoneCode=phoneCode;
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
        passwordController.clear();
        confirmPasswordController.clear();
        if (type == AppConstants.userType) {
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
        } else {
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
        }
      });
    } on Exception catch (e) {
      debugPrint("=====> Sign up catch error fire store $e");
    }finally{
      loading(false);
    }
  }


  void loginUser(String email, String password, String userType) async {
    isLoading = true;
    update();
    print(password);
    print(email);
    try {
  await auth
      .signInWithEmailAndPassword(
          email: email.trim(), password: password.trim())
      .then((value) async {
    // Fluttertoast.showToast(
    //     msg: "Login Successfully",
    //     backgroundColor: AppColors.blue_100,
    //     textColor: AppColors.black_100,
    //     fontSize: 14,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM
    // );
    DocumentSnapshot data = await firebaseFireStore
        .collection(AppConstants.users)
        .doc(value.user!.uid)
        .get();
    UserModel userData = UserModel.fromMap(data);
    debugPrint("=======> Uid ${data['uid']}");
    debugPrint("=======> User Type ${userData.role} and $userType");
  
    if (userData.role == userType) {
      await PrefsHelper.setString(AppConstants.logged, userData.role);
      if (userData.role == AppConstants.userType) {
        Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
        _dataController.setData(
            userNameD: userData.userName!,
            userRoleD: userData.role!,
            uidD: userData.uid!,
            imageD: userData.imageSrc!,
            authTypeD: userData.authType!);
        usernameController.clear();
        passwordController.clear();
      } else {
        Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
        _dataController.setData(
            userNameD: userData.userName!,
            userRoleD: userData.role!,
            uidD: userData.uid!,
            imageD: userData.imageSrc!,
            authTypeD: userData.authType!);
        usernameController.clear();
        passwordController.clear();
      }
    } else {
      Get.snackbar("Error", "User not found", colorText: Colors.red);
    }
  }).catchError((e) {
    Fluttertoast.showToast(
        msg: e!.message,
        backgroundColor: AppColors.blue_100,
        textColor: AppColors.white  ,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );
  
    isLoading = false;
    update();
  });
} finally {
 isLoading = false;
    update();
}

    // usernameController.text = "";
    // passwordController.text = "";

    isLoading = false;
    update();
  }

  Future<void> signInWithGoogle(String userType) async {
    // Trigger the authentication flow
    try {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  
  if (googleAuth != null) {
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userData =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("=======> Google Sign in Complete ");
   if(userData.user !=null){
     DocumentSnapshot data = await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(userData.user!.uid)
        .get();
    if (data.exists) {
      UserModel userData = UserModel.fromMap(data);
      debugPrint("=======> Uid ${data['uid']}");
      debugPrint("=======> User Type ${userData.role}");
     if (userData.role == userType) {
        await PrefsHelper.setString(AppConstants.logged, userData.role);
        if (userData.role == AppConstants.userType) {
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
          _dataController.setData(
              userNameD: userData.userName!,
              userRoleD: userData.role!,
              uidD: userData.uid!,
              imageD: userData.imageSrc!,
              authTypeD: userData.authType!);
          usernameController.clear();
          passwordController.clear();
        } else {
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
          _dataController.setData(
              userNameD: userData.userName!,
              userRoleD: userData.role!,
              uidD: userData.uid!,
              imageD: userData.imageSrc!,
              authTypeD: userData.authType!);
          usernameController.clear();
          passwordController.clear();
        }
      } else {
        Get.snackbar("Error", "User not found", colorText: Colors.red);
      }
    } else {
      Get.to(MoreSignUpScreen(uid: userData.user!.uid, email:userData.user!.email??"", image:userData.user!.photoURL??"", name:userData.user!.displayName??"", userType: userType));
    }
   }
  }
} on Exception catch (e) {
 debugPrint("Oops, Something wrong error $e");
  
}
  }


  Future<void> appleInWithGoogle(String userType) async {
    // Trigger the authentication flow
    try {

       final authProvider =  AppleAuthProvider();
  
    UserCredential userData =
        await FirebaseAuth.instance.signInWithProvider(authProvider);
   if(userData.user !=null){
     print("=======> Apple Sign in Complete ");
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(userData.user!.uid)
        .get();
    if (data.exists) {
      UserModel userData = UserModel.fromMap(data);
      debugPrint("=======> Uid ${data['uid']}");
      debugPrint("=======> User Type ${userData.role}");
     if (userData.role == userType) {
        await PrefsHelper.setString(AppConstants.logged, userData.role);
        if (userData.role == AppConstants.userType) {
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
          _dataController.setData(
              userNameD: userData.userName!,
              userRoleD: userData.role!,
              uidD: userData.uid!,
              imageD: userData.imageSrc!,
              authTypeD: userData.authType!);
          usernameController.clear();
          passwordController.clear();
        } else {
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
          _dataController.setData(
              userNameD: userData.userName!,
              userRoleD: userData.role!,
              uidD: userData.uid!,
              imageD: userData.imageSrc!,
              authTypeD: userData.authType!);
          usernameController.clear();
          passwordController.clear();
        }
      } else {
        Get.snackbar("Error", "User not found", colorText: Colors.red);
      }
    } else {
      Get.to(MoreSignUpScreen(uid: userData.user!.uid, email:userData.user!.email??"", image:userData.user!.photoURL??"", name:userData.user!.displayName??"", userType: userType));
    }
   }
} on Exception catch (e) {
 debugPrint("Oops, Something wrong error $e");
  
}
  }







  ///  <------------- Sign out------------->
  var isSignOutLoad = false.obs;
  final LocalizationController localizationController=Get.find<LocalizationController>();
  signOut() async {
    try {
      isSignOutLoad(true);
      await auth.signOut().then((value) async {
        localizationController.setLanguage(Locale('en',"US"));
        Get.back();
        Get.offAll(()=>const OnboardScreen());
        Get.find<SpHomeController>().onDelete();
        Get.find<SpProfileController>().onDelete();

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
}
