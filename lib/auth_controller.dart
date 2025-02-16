import 'package:blogsphere/auth_service.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoggedIn = false.obs;
  User? get user => FirebaseAuth.instance.currentUser;

  Future<void> login(String email, String password) async {
    final user = await _authService.signInWithEmail(email, password);
    if (user != null) {
      isLoggedIn.value = true;
    }
  }

  Future<void> signUp(String email, String password) async {
    final user = await _authService.signUpWithEmail(email, password);
    if (user != null) {
      isLoggedIn.value = true;
    }
  }


}