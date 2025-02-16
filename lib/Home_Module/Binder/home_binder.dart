import 'package:blogsphere/Home_Module/Controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}