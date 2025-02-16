import 'package:blogsphere/App_const.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/effects/offset_text.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/enums/animation_type.dart';
import 'package:blogsphere/Custom_Widget/Button/Pretty_wave_Button.dart';
import 'package:blogsphere/Register_Module/Controller/register_controller.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Custom_Widget/Animated_Text/enums/slide_animation_type.dart';
import '../../Custom_Widget/Loader/ink_drop.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({Key? key}) : super(key: key);

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: size.height * 0.30,
              width: double.infinity,
              child: Center(
                child: OffsetText(
                  text: 'Blog Sphere',
                  duration: const Duration(seconds: 4),
                  type: AnimationType.word,
                  isInfinite: false,
                  mode: AnimationMode.repeatNoReverse,
                  slideType: SlideAnimationType.alternateLR,
                  textStyle: TextStyle(
                      color: AppConst.coolMintColor,
                      fontSize: size.height * 0.035,
                      fontFamily: AppConst.bold,
                      letterSpacing: 6),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registration',
                  style: TextStyle(
                    color: AppConst.primaryColor,
                    fontSize: size.height * 0.040,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(
                  height: size.height * 0.03,
                  thickness: 2.5,
                  endIndent: 180,
                  indent: 3,
                  color: AppConst.primaryColor,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),

                // Center(
                //   child: Stack(
                //     children: [
                //       FluttermojiCircleAvatar(
                //         radius: size.height * 0.05,
                //       ),
                //       Positioned(
                //         bottom: 0,
                //         right: 0,
                //         child: GestureDetector(
                //           onTap: () {
                //             controller.showAvatarCustomizer(context);
                //             // Get.toNamed(AppRoutes.fluttermojiscreen);
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.3),
                //                   spreadRadius: 1,
                //                   blurRadius: 4,
                //                   offset: const Offset(
                //                       2, 3), // changes position of shadow
                //                 ),
                //               ],
                //             ),
                //             child: CircleAvatar(
                //               radius: 16,
                //               backgroundColor: AppConst.whiteColor,
                //               child: SvgPicture.asset(
                //                 AppConst
                //                     .pencil, // Assuming you have a pencil icon for editing
                //                 height: size.width * 0.050,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Center(
                  child: Stack(
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: AppConst.primaryColor,
                          backgroundImage: controller.profileImage.value != null
                              ? FileImage(controller.profileImage.value!)
                              : null,
                          child: controller.profileImage.value == null
                          //     ? const Icon(
                          //   Icons.person,
                          //   size: 50,
                          //   color: Colors.white,
                          // )
                          ? SvgPicture.asset(AppConst.people,color: Colors.white,height: size.height * 0.05,)
                              : null,
                        );
                      }),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              controller.selectAndUploadImage(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(2, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: AppConst.coolMintColor,
                                child: SvgPicture.asset(
                                  AppConst.pencil,
                                  height: size.width * 0.050,
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                // Name Field
                Container(
                  height: size.height * .06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      right:
                          BorderSide(color: AppConst.primaryColor, width: 1.8),
                      left: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      top: BorderSide(color: AppConst.primaryColor, width: 1.8),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: SvgPicture.asset(AppConst.people)),
                      VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: controller.namecontroller.value,
                          focusNode: controller.nameFocusNode.value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Name',
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
                  height: size.height * 0.020,
                ),

                // Date Of Birth
                Container(
                  height: size.height * .06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      right:
                          BorderSide(color: AppConst.primaryColor, width: 1.8),
                      left: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      top: BorderSide(color: AppConst.primaryColor, width: 1.8),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await controller.pickDateOfBirth(context);
                    },
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: SvgPicture.asset(AppConst.calender)),
                        VerticalDivider(
                          thickness: 2,
                          endIndent: 10,
                          indent: 11,
                          color: AppConst.primaryColor,
                        ),
                        Expanded(
                          child: Obx(
                            () => TextFormField(
                              enabled: false,
                              controller: controller.dobcontroller.value,
                              focusNode: controller.dobFocusNode.value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.selectedDate.value.isEmpty
                                    ? 'Select your Date of Birth'
                                    : controller.selectedDate.value,
                                hintStyle: TextStyle(
                                  color: AppConst.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                // Gender Field
                Container(
                  height: size.height * .06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      right:
                          BorderSide(color: AppConst.primaryColor, width: 1.8),
                      left: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      top: BorderSide(color: AppConst.primaryColor, width: 1.8),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.060),
                        child: SvgPicture.asset(AppConst.gender),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => Radio<String>(
                                value: 'Male',
                                activeColor: AppConst.primaryColor,
                                groupValue: controller.selectedGender.value,
                                onChanged: (value) {
                                  controller.selectedGender.value = value!;
                                  controller.isGenderValid.value = true;
                                },
                              ),
                            ),
                            Text('Male',
                                style: TextStyle(
                                    color: AppConst.primaryColor,
                                    fontSize: size.height * 0.019)),
                            Obx(
                              () => Radio<String>(
                                value: 'Female',
                                activeColor: AppConst.primaryColor,
                                groupValue: controller.selectedGender.value,
                                onChanged: (value) {
                                  controller.selectedGender.value = value!;
                                  controller.isGenderValid.value = true;
                                },
                              ),
                            ),
                            Text('Female',
                                style: TextStyle(
                                    color: AppConst.primaryColor,
                                    fontSize: size.height * 0.019)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                // Mobile Number Field
                Container(
                  height: size.height * .06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      right:
                          BorderSide(color: AppConst.primaryColor, width: 1.8),
                      left: BorderSide(
                          color: AppConst.primaryColor,
                          width: size.width * 0.004),
                      top: BorderSide(color: AppConst.primaryColor, width: 1.8),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: SvgPicture.asset(AppConst.phone)),
                      VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: controller.mobilecontroller.value,
                          focusNode: controller.mobileFocusNode.value,
                          maxLength: 10,
                          buildCounter: (
                            BuildContext context, {
                            required int currentLength,
                            required bool isFocused,
                            required int? maxLength,
                          }) {
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your mobile number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                // Email Field
                Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppConst.primaryColor,
                              width: size.width * 0.004),
                          right: BorderSide(
                              color: AppConst.primaryColor, width: 1.8),
                          left: BorderSide(
                              color: AppConst.primaryColor,
                              width: size.width * 0.004),
                          top: BorderSide(
                              color: AppConst.primaryColor, width: 1.8)),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: SvgPicture.asset(AppConst.emailicon)),
                      VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailcontroller.value,
                          focusNode: controller.emailFocusNode.value,
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
                  height: size.height * 0.020,
                ),
                // Container(
                //   height: size.height * .06,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //           color: AppConst.primaryColor,
                //           width: size.width * 0.004),
                //       right:
                //           BorderSide(color: AppConst.primaryColor, width: 1.8),
                //       left: BorderSide(
                //           color: AppConst.primaryColor,
                //           width: size.width * 0.004),
                //       top: BorderSide(color: AppConst.primaryColor, width: 1.8),
                //     ),
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Obx(() => DropdownButtonHideUnderline(
                //               child: DropdownButton<String>(
                //                 iconEnabledColor: AppConst.primaryColor,
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: size.width * 0.020),
                //                 hint: Padding(
                //                   padding: EdgeInsets.symmetric(
                //                       horizontal: size.width * 0.020),
                //                   child: Text(
                //                     'Select State',
                //                     style:
                //                         TextStyle(color: AppConst.primaryColor),
                //                   ),
                //                 ),
                //                 value: controller.selectedState.value.isEmpty
                //                     ? null
                //                     : controller.selectedState.value,
                //                 items: controller.states.map((state) {
                //                   return DropdownMenuItem<String>(
                //                     value: state,
                //                     child: Padding(
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: size.width * 0.030),
                //                       child: Text(
                //                         state,
                //                         style: TextStyle(
                //                             color: AppConst.primaryColor),
                //                       ),
                //                     ),
                //                   );
                //                 }).toList(),
                //                 onChanged: (value) {
                //                   controller.selectedState.value = value!;
                //                   controller.selectedCity.value =
                //                       ''; // Reset city when state changes
                //                 },
                //               ),
                //             )),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: size.height * 0.020),
                // Container(
                //   height: size.height * .06,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //           color: AppConst.primaryColor,
                //           width: size.width * 0.004),
                //       right:
                //           BorderSide(color: AppConst.primaryColor, width: 1.8),
                //       left: BorderSide(
                //           color: AppConst.primaryColor,
                //           width: size.width * 0.004),
                //       top: BorderSide(color: AppConst.primaryColor, width: 1.8),
                //     ),
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Obx(() {
                //           final isStateSelected =
                //               controller.selectedState.value.isNotEmpty;
                //           return DropdownButtonHideUnderline(
                //             child: DropdownButton<String>(
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: size.width * 0.020),
                //               iconEnabledColor: AppConst.primaryColor,
                //               hint: Padding(
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: size.width * 0.030),
                //                 child: Text(
                //                   'Select City',
                //                   style: TextStyle(
                //                       color: isStateSelected
                //                           ? AppConst.primaryColor
                //                           : Colors.grey),
                //                 ),
                //               ),
                //               value: controller.selectedCity.value.isEmpty
                //                   ? null
                //                   : controller.selectedCity.value,
                //               items: isStateSelected
                //                   ? controller
                //                       .getCities(controller.selectedState.value)
                //                       .map((city) {
                //                       return DropdownMenuItem<String>(
                //                         value: city,
                //                         child: Padding(
                //                           padding: EdgeInsets.symmetric(
                //                               horizontal: size.width * 0.030),
                //                           child: Text(
                //                             city,
                //                             style: TextStyle(
                //                                 color: AppConst.primaryColor),
                //                           ),
                //                         ),
                //                       );
                //                     }).toList()
                //                   : [],
                //               onChanged: isStateSelected
                //                   ? (value) {
                //                       controller.selectedCity.value = value!;
                //                     }
                //                   : null,
                //             ),
                //           );
                //         }),
                //       ),
                //     ],
                //   ),
                // ),

                // Password Field
                Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppConst.primaryColor,
                              width: size.width * 0.004),
                          right: BorderSide(
                              color: AppConst.primaryColor, width: 1.8),
                          left: BorderSide(
                              color: AppConst.primaryColor,
                              width: size.width * 0.004),
                          top: BorderSide(
                              color: AppConst.primaryColor, width: 1.8)),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: SvgPicture.asset(
                          AppConst.passicon,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Obx(
                        () => Expanded(
                          child: TextFormField(
                            controller: controller.passcontroller.value,
                            obscureText: !controller.isPasswordVisible.value,
                            focusNode: controller.passFocusNode.value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                color: AppConst.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                            icon: controller.isPasswordVisible.value
                                ? Icon(
                                    Icons.visibility_sharp,
                                    color: AppConst.primaryColor,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: AppConst.primaryColor,
                                  )),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),
                // Confirm Password Field
                Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppConst.primaryColor,
                              width: size.width * 0.004),
                          right: BorderSide(
                              color: AppConst.primaryColor, width: 1.8),
                          left: BorderSide(
                              color: AppConst.primaryColor,
                              width: size.width * 0.004),
                          top: BorderSide(
                              color: AppConst.primaryColor, width: 1.8)),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: SvgPicture.asset(
                          AppConst.passicon,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 11,
                        color: AppConst.primaryColor,
                      ),
                      Obx(
                        () => Expanded(
                          child: TextFormField(
                            controller: controller.confirmpasscontroller.value,
                            focusNode: controller.conformpassFocusNode.value,
                            obscureText:
                                !controller.isconfPasswordVisible.value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter confirm your password',
                              hintStyle: TextStyle(
                                color: AppConst.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                            onPressed: () {
                              controller.toggleconfPasswordVisibility();
                            },
                            icon: controller.isconfPasswordVisible.value
                                ? Icon(
                                    Icons.visibility_sharp,
                                    color: AppConst.primaryColor,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: AppConst.primaryColor,
                                  )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                // Submit Button
                Obx((){
                  return controller.isLoading.value ? Center(child: InkDrop(size: 30, color: AppConst.primaryColor),) : Center(
                    child: PrettyWaveButton(
                      backgroundColor: AppConst.primaryColor,
                      horizontalPadding: size.height * 0.080,
                      verticalPadding: 10,
                      child: Text(
                        'Ready To Launch',
                        style: TextStyle(
                            color: AppConst.coolMintColor,
                            fontSize: size.height * 0.017,
                            fontFamily: AppConst.bold),
                      ),
                      onPressed: () {
                        controller.register_Validator(context);
                      },
                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account ?",
                        style: TextStyle(
                            color: AppConst.primaryColor,
                            fontSize: size.height * 0.020,
                            fontWeight: FontWeight.w400)),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.loginscreen);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: AppConst.primaryColor,
                              fontSize: size.height * 0.020,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}