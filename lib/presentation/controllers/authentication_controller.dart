import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp/data/user_repository.dart';
import 'package:flutter_newsapp/presentation/views/authentication_view.dart';
import 'package:flutter_newsapp/presentation/views/home_view.dart';
import 'package:flutter_newsapp/utils/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum UserState {
  loading,
  authenticated,
  unauthenticated,
}

class AuthenticationController extends GetxController with StateMixin<User> {
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    // isSignedIn();
    // userRepository.isSignedIn().then((data) {
    //   change(data, status: RxStatus.success());
    // }, onError: (err) {
    //   change(null, status: RxStatus.error(err.toString()));
    // });
    super.onInit();
  }

  bool isSignedIn()  {
     return userRepository.isSignedIn();
  }

  signOut() async{
    // loggedIn = userRepository.signOut() != null;
    //
    // state = loggedIn ? UserState.authenticated : UserState.unauthenticated;
    userRepository.signOut().then((data) {
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  signInWithGoogle() async{
    // if(!loggedIn) {
    //   loggedIn = userRepository.signInWithGoogle() != null;
    //   state = loggedIn ? UserState.authenticated : UserState.unauthenticated;
    // }

    userRepository.signInWithGoogle().then((data) {
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });

  }
// FirebaseApp firebaseApp;
// User firebaseUser;
// FirebaseAuth firebaseAuth;

// bool checkUserLoggedIn() {
//   if (firebaseAuth == null) {
//     firebaseAuth = FirebaseAuth.instance;
//     update();
//   }
//   if (firebaseAuth.currentUser == null) {
//     return false;
//   } else {
//     firebaseUser = firebaseAuth.currentUser;
//     update();
//     return true;
//   }
// }
//
// Future<void> signInWithGoogle() async {
//   try {
//     // Show loading screen till we complete our login workflow
//     Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
//     // Create Firebase auth for storing auth related info such as logged in user etc.
//     firebaseAuth = FirebaseAuth.instance;
//     // Start of google sign in workflow
//     final googleUser = await GoogleSignIn().signIn();
//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     final userCredentialData =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//     firebaseUser = userCredentialData.user;
//     // update the state of controller variable to be reflected throughout the app
//     update();
//     Get.offAll(HomeView());
//   } catch (exception) {
//     Get.back();
//     // Show Error if we catch any error
//     Get.snackbar('Sign In Error ${exception.toString()}', 'Error Signing in',
//         duration: Duration(seconds: 5),
//         backgroundColor: Colors.black,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//         icon: Icon(
//           Icons.error,
//           color: Colors.red,
//         ));
//   }
// }
//
// Future<void> signOut() async {
//   // Show loading widget till we sign out
//   Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
//   await firebaseAuth.signOut();
//   Get.back();
//   // Navigate to Login again
//   Get.offAll(AuthenticationView());
// }
}
