import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:find_worker/controller/data_controller.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/core/share_pre.dart';
import 'package:find_worker/model/user_model.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:find_worker/utils/app_constents.dart';
import 'package:find_worker/view/screens/service_provider/sp_bottom_nav_bar/sp_bottom_nav_bar_screen.dart';
import 'package:find_worker/view/screens/user/user_auth/user_sign_in/user_sign_in_screen.dart';
import 'package:find_worker/view/screens/user/user_bottom_nav_bar/user_bottom_nav_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AuthenticationController extends GetxController{

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
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController roleType = TextEditingController();
  String phoneCode = "+93";
  String year = "";
  String month = "";
  String day = "";


  // Date TextFormField
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  List<String> genderList = ["Male", "Female", "Others"];
  int selectedGender = 0;


  final auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  /// forget

  /*late String email;
  late EmailOTP emailOTP;*/

  final TextEditingController otpController = TextEditingController();

  /// for firebase sign up

  Future<void> registerUser() async {
    isLoading = true;
    update();
    if(registerFormKey.currentState!.validate()) {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim()

      ).then((value)async{
        print("Srabon");
      await  postDetailsToFireStore();


      }).catchError((e){
        Fluttertoast.showToast(
            msg: e!.message,
            backgroundColor: AppColors.blue_100,
            textColor: AppColors.white,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
        isLoading = false;
        update();
      });
    }
    isLoading = false;
    update();
  }

  /// added user info in firebase fire store
  var token="";
  fcmToken()async{
    token = (await FirebaseMessaging.instance.getToken())!;
  }
  postDetailsToFireStore() async{
   //await fcmToken();
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = nameController.text.toString();
    userModel.dob =DateTime(int.parse(year),int.parse(month),int.parse(day));
    userModel.phone = phoneCode+phoneController.text.toString();
    userModel.address =addressController.text.toString();
    userModel.authType=AppConstants.normalUser;
    userModel.role=roleType.text;
    userModel.password=passController.text;
    userModel.timestamp=DateTime.now();
    userModel.status="Online";
    userModel.imageSrc="";
    userModel.fcmToken=token;
    userModel.gender=genderList[selectedGender];
    try {
      await firebaseFireStore.collection(AppConstants.users)
          .doc(user.uid)
          .set(userModel.toMap()).then((value){
        Fluttertoast.showToast(
            msg: "Account created successfully",
            backgroundColor: AppColors.blue_100,
            textColor: AppColors.black_100,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
        PrefsHelper.setString(AppConstants.logged, roleType.text);
        if(roleType.text==AppConstants.userType){
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
        }else{
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
        }
      });
    } on Exception catch (e) {
      debugPrint("=====> Sign up catch error fire store $e");
    }

  }

  /// sendOtp screen


/*  Future<void> sendOtpToEmail() async{
    final emailOtp = EmailOTP();

    bool isLoading = false;

      isLoading = true;
    update();

    emailOtp.setConfig(
        appEmail: "mirzamahmud.cse.bubt202@gmail.com",
        appName: "EzyRack",
        userEmail: emailController.text.toString(),
        otpLength: 5,
        otpType: OTPType.digitsOnly
    );

    if(await emailOtp.sendOTP() == true){
      Fluttertoast.showToast(
          msg: "OTP has been sent",
          backgroundColor: AppColors.blue_100,
          textColor: AppColors.black_100,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );


        isLoading = false;
        update();

      Get.offAndToNamed(AppRoute.userEmailOtpScreen, arguments: [emailController.text.toString(), emailOtp]);
    }
    else{
      Fluttertoast.showToast(
          msg: "Oops! OTP send failed",
          backgroundColor: AppColors.blue_100,
          textColor: AppColors.black_100,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

        isLoading = false;
      update();
    }


      isLoading = false;
     update();
  }*/

/*  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  GoogleSignInAccount? googleUser;
  var googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {

    try{
      googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      await firebaseFireStore.collection("users")
          .doc(user!.uid)
          .set({
        "username" : user.displayName,
        "email" : user.email,
        "imageSrc" : user.photoURL,
        "phoneNumber" : user.phoneNumber
      });

      return user;
    } catch(e){
      print("Error Message: $e");
    }
  }
  void handleGoogleLogin() async{
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator(color: AppColors.blue_100));
      },
    );


    try{
      User? user = await signInWithGoogle();
      if(user != null){
        Get.offAndToNamed(AppRoute.homeScreen);
      }else{
        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }*/

 /* Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }*/

  /// firebase sign in
 /* Future<void> loginUser() async{
    isLoading = true;
    update();
      await auth.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim()
      ).then((uid) => {
        Fluttertoast.showToast(
            msg: "Login Successfully",
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        ),
      Get.to(UserBottomNavBarScreen(currentIndex: 0))
      }).catchError((e){
        Fluttertoast.showToast(
            msg: e!.message,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
        isLoading = false;
        update();
      });

    usernameController.text = "";
    passwordController.text = "";

    isLoading = false;
    update();
  }*/

  void loginUser(String email, String password) async{

    isLoading = true;
    update();
      print(password);
      print(email);
      await auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim()
      ).then((value)async{
        Fluttertoast.showToast(
            msg: "Login Successfully",
            backgroundColor: AppColors.blue_100,
            textColor: AppColors.black_100,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
        DocumentSnapshot data = await firebaseFireStore.collection(AppConstants.users).doc(value.user!.uid).get();
        UserModel userData= UserModel.fromMap(data);
        debugPrint("=======> Uid ${data['uid']}");
        debugPrint("=======> User Type ${userData.role}");
       await PrefsHelper.setString(AppConstants.logged, userData.role);
        if(userData.role==AppConstants.userType){
          Get.offAll(UserBottomNavBarScreen(currentIndex: 0));
          _dataController.setData(userNameD: userData.userName!,
              userRoleD:userData.role!,
              uidD:userData.uid!,
              imageD:userData.imageSrc!,
              authTypeD:userData.authType!);
        }else{
          Get.offAll(SpBottomNavBarScreen(currentIndex: 0));
          _dataController.setData(userNameD: userData.userName!,
              userRoleD:userData.role!,
              uidD:userData.uid!,
              imageD:userData.imageSrc!,
              authTypeD:userData.authType!);
        }
      }
      ).catchError((e){
        // Fluttertoast.showToast(
        //     msg: e!.message,
        //     backgroundColor: AppColors.blue_100,
        //     textColor: AppColors.white  ,
        //     fontSize: 14,
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM
        // );

        isLoading = false;
        update();
      });

    // usernameController.text = "";
    // passwordController.text = "";

    isLoading = false;
    update();
  }



  Future<void> pickedDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme:  const ColorScheme.light(
                primary: AppColors.blue_100, // <-- SEE HERE
                onPrimary: AppColors.white, // <-- SEE HERE
                onSurface: AppColors.blue_100, // <-- SEE HERE
              ),
            ),
            child: child!
        )
    );
    if (picked != null) {
      year = picked.year.toString();
      month = picked.month.toString();
      day = picked.day.toString();
      update();
    }
  }


  ///  <------------- Sign out------------->
  var isSignOutLoad=false.obs;
  signOut()async{
      try {
        isSignOutLoad(true);
             await auth.signOut().then((value){
         Get.offAll(UserSignIn());
         debugPrint("=========> Successful sign out");
        isSignOutLoad(false);
             });
      } on Exception catch (e) {
      debugPrint("=========> sign out catch error : $e");
      }finally{
        isSignOutLoad(false);
      }


  }


}