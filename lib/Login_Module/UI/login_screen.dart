
import 'package:blogsphere/Custom_Widget/Animated_Text/effects/offset_text.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/enums/animation_type.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/enums/slide_animation_type.dart';
import 'package:blogsphere/Custom_Widget/Button/Pretty_wave_Button.dart';
import 'package:blogsphere/Custom_Widget/Loader/ink_drop.dart';
import 'package:blogsphere/Login_Module/Controller/login_controller.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:get/get.dart';

import '../../App_const.dart';



class LoginScreen extends GetView<LoginController>{
  LoginScreen({Key? key}) : super(key: key);

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConst.whiteColor,
      body: ListView(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(flip: true),
            child: Container(
                decoration: BoxDecoration(
                  color: AppConst.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1.0),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: size.height * 0.35,
                width: double.infinity,
                child: Center(
                    // child: Text("Campus Quest",style: TextStyle(color: AppConst.coolMintColor,fontSize: size.height * 0.035,fontFamily: AppConst.bold,letterSpacing: 6),),
                    child: OffsetText(
                      text: 'BlogSphere',
                      duration: const Duration(seconds: 4),
                      type: AnimationType.word,
                      isInfinite: false,
                      mode: AnimationMode.repeatNoReverse,
                      slideType: SlideAnimationType.alternateLR,
                      textStyle: TextStyle(color: AppConst.coolMintColor,fontSize: size.height * 0.035,fontFamily: AppConst.bold,letterSpacing: 6),
                    ),
                    // child: Image.asset(AppConst.logo,height: size.height * 0.30,)
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: AppConst.primaryColor,
                      fontSize: size.height * 0.040,
                      fontWeight: FontWeight.w400),
                ),
                Divider(
                  height: size.height * 0.03,
                  thickness: 2.5,
                  endIndent: 280,
                  indent: 3,
                  color: AppConst.primaryColor,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Container(
                  height: size.height * 0.06,
                  decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(color: AppConst.primaryColor,width: size.width * 0.004),
                      right: BorderSide(color: AppConst.primaryColor,width: 1.8),left: BorderSide(color: AppConst.primaryColor,width: size.width * 0.004),top: BorderSide(color: AppConst.primaryColor,width: 1.8)),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: size.width * 0.02),
                        child: Icon(
                          Icons.email_outlined,
                          color: AppConst.primaryColor,
                        ),
                      ),
                       VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.emailcontroller.value,
                          focusNode: controller.emailFocusNode.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              color: AppConst.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Container(
                  height: size.height * 0.06,
                  decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(color: AppConst.primaryColor,width: size.width * 0.004),right: BorderSide(color: AppConst.primaryColor,width: 1.8),left: BorderSide(color: AppConst.primaryColor,width: size.width * 0.004),top: BorderSide(color: AppConst.primaryColor,width: 1.8)),borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: size.width * 0.02),
                        child: Icon(
                          Icons.lock_outline,
                          color: AppConst.primaryColor,
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Obx(()=>Expanded(
                        child: TextFormField(
                          controller: controller.passcontroller.value,
                          focusNode: controller.passwordFocusNode.value,
                          obscureText: !controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: AppConst.blackColor,
                            ),
                          ),
                        ),

                      ),),
                      Obx(()=>IconButton(onPressed: (){
                        controller.togglePasswordVisibility();
                      }, icon: controller.isPasswordVisible.value ? Icon(Icons.visibility_sharp,color: AppConst.primaryColor,) : Icon(Icons.visibility_off,color: AppConst.primaryColor,)),)
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Obx(
                        //       () => Checkbox(
                        //     activeColor: AppConst.primaryColor,
                        //     value: controller.isRememberMeChecked.value,
                        //     onChanged: (value) {
                        //       controller.isRememberMeChecked.value = value!;
                        //     },
                        //   ),
                        // ),
                        // Text(
                        //   "Remember Me",
                        //   style: TextStyle(
                        //     // color: AppConst.text_Color,
                        //     fontSize: size.height * 0.019,
                        //   ),
                        // ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password logic
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppConst.primaryColor,
                          fontSize: size.height * 0.019,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Obx((){
                  return controller.isLoading.value
                      ? Center(child: InkDrop(size: 30, color: AppConst.primaryColor),)
                      : Center(
                    child: PrettyWaveButton(
                      backgroundColor: AppConst.primaryColor,
                      horizontalPadding: size.height * 0.080,
                      verticalPadding: 10,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: AppConst.coolMintColor,
                            fontSize: 25,
                            fontFamily: AppConst.bold
                        ),
                      ),
                      onPressed: () {
                        controller.login_Validator(context);
                      },
                    ),
                  );

                }),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an Account ?",style: TextStyle(color: AppConst.primaryColor,fontSize: size.height * 0.020,fontWeight: FontWeight.w400)),
                    TextButton(
                        onPressed: (){
                          Get.toNamed(AppRoutes.registrationscreen);
                        },
                        child: Text("Sign up",style: TextStyle(color: AppConst.primaryColor,fontSize: size.height * 0.020,fontWeight: FontWeight.w500),)
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}