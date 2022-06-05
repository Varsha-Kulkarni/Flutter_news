import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsapp/data/user_repository.dart';
import 'package:flutter_newsapp/presentation/controllers/authentication_controller.dart';
import 'package:flutter_newsapp/presentation/views/authentication_view.dart';
import 'package:flutter_newsapp/presentation/views/home_view.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
abstract class Routes {
  static const AUTHENTICATION = '/authentication';

}
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<IUserRepository>(() => HomeProvider());
    Get.lazyPut<IUserRepository>(() => UserRepository());
    Get.lazyPut(() => AuthenticationController());
  }
}
class AppPages {
  static const INITIAL = Routes.AUTHENTICATION;

  static final routes = [
  GetPage(
  name: Routes.AUTHENTICATION,
  page: () => AuthenticationView(),
  binding: AuthBinding(),)];
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

// class App extends StatelessWidget {
//   // Inject authenticationController to View.
//   final authenticationController = Get.put(AuthenticationController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthenticationController>(
//     builder: (_) => AuthenticationView());
//         // builder: (_) => authenticationController.obx((state) => HomeView(),
//             // onError: AuthenticationView(),
//             // onLoading: const Center(child: const CircularProgressIndicator())));
//   }
// }
