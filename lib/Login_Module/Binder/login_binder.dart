import 'package:blogsphere/Login_Module/Controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}