
import 'package:blogsphere/Bottom%20Navigation%20Bar/Bottom_Navigation_Screen/bottom_navigation_screen.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  var visible = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      visible.value = true;
    });

    Future.delayed(const Duration(seconds: 4), _checkLoginStatus);
  }

  void _checkLoginStatus() async {
    // await Future.delayed(Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAll(CompanyBottomNavigationScreen());
     // Get.offAllNamed(AppRoutes.bottomnavigationscreen);
    } else {
      Get.offAllNamed(AppRoutes.loginscreen);
    }
  }

  //
  // void navigateToNextScreen() {
  //   // Replace with your navigation logic, e.g., checking user login status
  //   Get.offAllNamed(AppRoutes.loginscreen);
  // }

}