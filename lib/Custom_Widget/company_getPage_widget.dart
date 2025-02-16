
import 'package:blogsphere/Bottom%20Navigation%20Bar/Controller/bottom_navigation_controller.dart';
import 'package:blogsphere/Home_Module/UI/home_screen.dart';
import 'package:blogsphere/Profile_Module/UI/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CompanyGetpageWidget extends StatelessWidget {
  final BottomNavigationController controller;

  CompanyGetpageWidget({required this.controller});

  Widget buildPage() {
    switch (controller.currentIndex.value) {
      case 0:
        return HomeScreen();
      case 1:
        return Center(child: Text('Interview Schedule Page'));
      case 2:
        return Center(child: Text('Third Screen'));
      case 3:
        return ProfileScreen();
      default:
        return Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => buildPage());
  }
}
