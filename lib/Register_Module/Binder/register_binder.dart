import 'package:blogsphere/Register_Module/Controller/register_controller.dart';
import 'package:get/get.dart';
class RegisterBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> RegisterController());
  }
}