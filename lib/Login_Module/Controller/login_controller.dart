
import 'package:blogsphere/App_const.dart';
import 'package:blogsphere/Bottom%20Navigation%20Bar/Bottom_Navigation_Screen/bottom_navigation_screen.dart';
import 'package:blogsphere/Custom_Widget/Toast/toast_enums.dart';
import 'package:blogsphere/Custom_Widget/Toast/toast_service.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  Rx<bool> isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  Rx<TextEditingController> emailcontroller = TextEditingController().obs;
  Rx<TextEditingController> passcontroller = TextEditingController().obs;
  // RxBool isRememberMeChecked = false.obs;
  RxBool isPasswordVisible = false.obs;

  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> passwordFocusNode = FocusNode().obs;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  Future<void>loginUser(context) async{
    isLoading.value = true;
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.value.text,
          password: passcontroller.value.text
      );
      final box = GetStorage();
      box.write('isFirstLogin', true);


      Get.offAll(CompanyBottomNavigationScreen());
      ToastService.showToast(
          context,
          leading: Icon(Icons.done_outline_rounded,color: AppConst.coolMintColor,),
          backgroundColor: AppConst.primaryColor,
          messageStyle: TextStyle(color: AppConst.coolMintColor,fontFamily: AppConst.medium),
          message: "Login Successfully",
          length: ToastLength.medium,
          shadowColor: AppConst.secoundaryColor,
          positionCurve: Curves.bounceOut,
          slideCurve: Curves.elasticInOut,
      );
    }catch(e){
      ToastService.showErrorToast(
        context,
        message: e.toString(),
        length: ToastLength.medium,
        positionCurve: Curves.bounceOut,
        slideCurve: Curves.elasticInOut,
      );
    }finally{
      isLoading.value = false;
    }
  }
  // void showFirstTimeLoginPopup(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.asset(AppConst.logo),
  //             const SizedBox(height: 20),
  //             const Text(
  //               'Welcome to the app!',
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Got it!'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void login_Validator(context){
    String? errorMessage;

    if(emailcontroller.value.text.isEmpty){
      errorMessage = "Please Enter Valid Email Address";
      emailFocusNode.value.requestFocus();
      showCustomToast(context: context,Message: errorMessage);
    }else if(passcontroller.value.text.isEmpty){
      errorMessage = "Please Enter Your Password";
      passwordFocusNode.value.requestFocus();
      showCustomToast(context: context,Message: errorMessage);
    }else{
      loginUser(context);
    }
  }

  void showCustomToast({
    required BuildContext context,
    required String Message,
  }) {
    ToastService.showToast(
      context,
      leading: Icon(Icons.error_outline_rounded,color: AppConst.coolMintColor,),
      backgroundColor: AppConst.primaryColor,
      messageStyle: TextStyle(color: AppConst.coolMintColor,fontFamily: AppConst.medium),
      message: Message,
      length: ToastLength.medium,
      shadowColor: AppConst.secoundaryColor,
      positionCurve: Curves.bounceOut,
      slideCurve: Curves.elasticInOut,
    );
  }

  @override
  void dispose() {
    emailFocusNode.value.dispose();
    passwordFocusNode.value.dispose();
    super.dispose();
  }
}