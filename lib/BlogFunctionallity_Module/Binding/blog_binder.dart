import 'package:blogsphere/BlogFunctionallity_Module/Controller/blog_controller.dart';
import 'package:get/get.dart';
class BlogBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BlogController());
  }
}