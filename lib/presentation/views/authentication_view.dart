import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_newsapp/presentation/controllers/authentication_controller.dart';
import 'package:flutter_newsapp/presentation/views/home_view.dart';
import 'package:get/get.dart';

class AuthenticationView extends StatelessWidget {
  // Inject authentication controller into the Authentication view
  final authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('News App'),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
          body: GetBuilder<AuthenticationController>(
    builder: (_) => authenticationController.isSignedIn() ? HomeView() : ElevatedButton(
                child: Text(
                  'Login with Google',
                ),
                onPressed: () {
                  // Call the sign in method
                  handleSignIn();
                },
              ),
    ));
        // body: Center(child: authenticationController.obx((state) {
        //   return state == null
        //       ? ElevatedButton(
        //           child: Text(
        //             'Login with Google',
        //           ),
        //           onPressed: () {
        //             // Call the sign in method
        //             handleSignIn();
        //           },
        //         )
        //       : HomeView();
        //   // }
        //   //
        // }, onError: handleError, onLoading: Center(child: const CircularProgressIndicator()) )));
  }

  void handleSignIn() {
    authenticationController.signInWithGoogle();

    // authenticationController.obx((state) => HomeView(),
    //     onError: (error) => handleError(error),
    //     onLoading: const Center(child: const CircularProgressIndicator()));
  }

  handleError(String error) {
    Get.snackbar(error, error,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ));
  }

  handleLoading() {
    const Center(child: const CircularProgressIndicator());
  }
}
