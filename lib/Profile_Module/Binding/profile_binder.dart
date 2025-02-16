import 'package:blogsphere/Profile_Module/Controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}