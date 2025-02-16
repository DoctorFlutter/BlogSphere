import 'package:blogsphere/App_const.dart';
import 'package:blogsphere/Bottom%20Navigation%20Bar/Controller/bottom_navigation_controller.dart';
import 'package:blogsphere/Custom_Widget/company_getPage_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class CompanyBottomNavigationScreen extends GetView<BottomNavigationController> {
  CompanyBottomNavigationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     BottomNavigationController controller = BottomNavigationController();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: controller.currentIndex.value,
        color: AppConst.primaryColor,
        buttonBackgroundColor: AppConst.primaryColor,
        backgroundColor: AppConst.whiteColor,
        height: 60,
        animationCurve: Curves.easeIn,
        animationDuration: const Duration(milliseconds: 300),
        // onTap: (index) {
        //   if (index == 2) {
        //     controller.showAddRequirementDialog(context);
        //   } else {
        //     controller.changePage(index);
        //   }
        // },
        onTap: (index) => controller.changePage(index),
        items:  [
          // Icon(Icons.list, size: 30,color: Colors.white,),
          SvgPicture.asset(AppConst.home,height: size.height * 0.035,),
          Icon(Icons.play_circle,size:  size.height * 0.035,color: Colors.white,),
          SvgPicture.asset(AppConst.notificatioIcon,color: Colors.white,height: size.height * 0.035,),
          const Icon(Icons.perm_identity, size: 34,color: Colors.white,),
        ],
      ),
      body: CompanyGetpageWidget(controller: controller),
    );
  }

}
