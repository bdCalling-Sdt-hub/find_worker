import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_worker/core/app_routes.dart';
import 'package:find_worker/model/user_model.dart';
import 'package:find_worker/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController{

  bool isObscure = true;
  bool isLoading = false;
  bool rememberMe = false;

  final loginFormKey = GlobalKey<FormState>();
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
  String phoneCode = "+225";
  String year = "";
  String month = "";
  String day = "";

  // Date TextFormField
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  /// for firebase sign up
  Future<void> registerUser() async {
    isLoading = true;
    update();
    if(registerFormKey.currentState!.validate()) {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      ).then((value){
        postDetailsToFireStore();
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
  postDetailsToFireStore() async{

    User? user = auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = nameController.text.toString();
    userModel.year = yearController.text.toString();
    userModel.month = monthController.text.toString();
    userModel.day = dayController.text.toString();
    userModel.phone = phoneController.text.toString();
    userModel.address =addressController.text.toString();

    await firebaseFireStore.collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(
        msg: "Account created successfully",
        backgroundColor: AppColors.blue_100,
        textColor: AppColors.black_100,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );

    gotoNextScreen();
  }

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
  Future<void> loginUser() async{
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
        gotoNextScreen()
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
  }

  /// after login next screen
  void gotoNextScreen(){
    Get.offAndToNamed(AppRoute.homeScreen);
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

}