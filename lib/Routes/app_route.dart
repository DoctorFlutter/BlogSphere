import 'package:blogsphere/BlogFunctionallity_Module/Binding/blog_binder.dart';
import 'package:blogsphere/BlogFunctionallity_Module/UI/blog_screen.dart';
import 'package:blogsphere/Login_Module/Binder/login_binder.dart';
import 'package:blogsphere/Login_Module/UI/login_screen.dart';
import 'package:blogsphere/Profile_Module/Binding/profile_binder.dart';
import 'package:blogsphere/Profile_Module/UI/profile_screen.dart';
import 'package:blogsphere/Register_Module/Binder/register_binder.dart';
import 'package:blogsphere/Register_Module/UI/RegisterScreen.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:get/get.dart';
import '../Splash_Module/Binding/splash_binder.dart';
import '../Splash_Module/UI/splash_screen.dart';

class PageRoutes {
  static const initial = AppRoutes.splashscreen;

  static final routes = <GetPage>[
    GetPage(
        name: AppRoutes.splashscreen,
        page: () => SplashScreen(),
        binding: SplashBinder()),
    GetPage(
        name: AppRoutes.loginscreen,
        page: () => LoginScreen(),
        binding: LoginBinder()),
    GetPage(
        name: AppRoutes.registrationscreen,
        page: () => RegisterScreen(),
        binding: RegisterBinder()),
    GetPage(
      name: AppRoutes.blogscreen,
      page: () => BlogScreen(),
      binding: BlogBinder(),
    ),

    GetPage(
        name: AppRoutes.profilescreen,
        page: () => ProfileScreen(),
        binding: ProfileBinder()),
  ];
}
