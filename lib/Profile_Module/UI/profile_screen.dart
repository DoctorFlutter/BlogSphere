import 'package:blogsphere/App_const.dart';
import 'package:blogsphere/Custom_Widget/Button/Pretty_wave_Button.dart';
import 'package:blogsphere/Custom_Widget/Loader/ink_drop.dart';
import 'package:blogsphere/Profile_Module/Controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConst.coolMintColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(color: AppConst.primaryColor)),
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: controller.streamUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: InkDrop(size: 30, color: AppConst.primaryColor));
          }

          if (snapshot.hasError || controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                snapshot.hasError
                    ? "Error loading data."
                    : controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No user data found.", style: TextStyle(color: Colors.black54)),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Obx(() {
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: AppConst.primaryColor,
                            backgroundImage:controller.profileImageBytes.value.isNotEmpty
                                ? MemoryImage(controller.profileImageBytes.value)
                                : null,
                            child: controller.profileImage.value == null
                                ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                                : null,
                          );
                        }),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                controller.selectAndUploadImage(Get.context!);
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
                                  backgroundColor: AppConst.whiteColor,
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
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      controller.name.value,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  controller.buildProfileField(
                    context: context,
                    icon: Icons.person,
                    value: controller.name.value,
                    fieldKey: 'name',
                  ),
                  controller.buildProfileField(
                    context: context,
                    icon: Icons.email,
                    // title: 'Email',
                    value: controller.email.value,
                    fieldKey: 'email',
                    editable: false,
                  ),
                  controller.buildProfileField(
                    context: context,
                    icon: Icons.phone,
                    // title: 'Mobile',
                    value: controller.mobile.value,
                    fieldKey: 'mobile',
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: AppConst.primaryColor), // Icon
                        const SizedBox(width: 16),
                        Obx(() => Expanded(
                          child: Text(
                            controller.dob.value,
                            style:  TextStyle(fontSize: 16, color: AppConst.primaryColor,fontWeight: FontWeight.bold),
                          ),
                        )),
                        GestureDetector(
                          onTap: () async {
                            await controller.pickDateOfBirth(context);
                          },
                          child: Icon(Icons.edit, color: AppConst.primaryColor),
                        ),
                      ],
                    ),
                  ),

                  controller.buildProfileField(
                    context: context,
                    icon: Icons.person_outline,
                    value: controller.gender.value,
                    fieldKey: 'gender',
                  ),
                  const SizedBox(height: 20),
                  PrettyWaveButton(
                      horizontalPadding: size.width * 0.25,
                      backgroundColor: AppConst.primaryColor,
                      child: Text("Logout",style: TextStyle(color: AppConst.whiteColor,fontSize: size.height * 0.020,fontWeight: FontWeight.bold),),
                      onPressed: (){
                        controller.logout();
                      }
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}