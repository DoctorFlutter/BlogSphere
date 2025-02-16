
import 'package:blogsphere/Splash_Module/Controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_const.dart';


class SplashScreen extends GetView<SplashController>{
  SplashScreen({Key? key}) : super(key: key);
  
  SplashController controller = Get.put(SplashController());
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Obx(
          () => Scaffold(
        backgroundColor: AppConst.whiteColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: controller.visible.value ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  AppConst.logo,
                  fit: BoxFit.contain,
                  height: Get.height / 2,
                  width: Get.height / 3,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 5,
            //   child: Text("Version : ${controller.rootController.appVersion.value}",
            //     style: Get.textTheme.bodyLarge!.copyWith(
            //       fontSize: AppSpacings.s20,
            //       fontWeight: FontWeight.w700,
            //       color: ThemeService.primaryColor.withOpacity(0.8),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}