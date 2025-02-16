import 'package:blogsphere/Splash_Module/Controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}