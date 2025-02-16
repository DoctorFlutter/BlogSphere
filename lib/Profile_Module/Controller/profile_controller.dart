import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blogsphere/App_const.dart';
import 'package:blogsphere/Custom_Widget/Toast/toast_enums.dart';
import 'package:blogsphere/Custom_Widget/Toast/toast_service.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController mobileController = TextEditingController();
  RxList<String> statesList = <String>[].obs;
  RxList<String> citiesList = <String>[].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString profileImage = ''.obs;
  Rx<Uint8List> profileImageBytes = Uint8List(0).obs;

  RxString city = ''.obs;
  RxString dob = ''.obs;
  RxString gender = ''.obs;
  RxString mobile = ''.obs;
  RxString state = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mobileController.text = mobile.value;
  }
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.loginscreen);
  }

  Stream<Map<String, dynamic>> streamUserData() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return _firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
          if (snapshot.exists) {
            var userData = snapshot.data() as Map<String, dynamic>;

            name.value = userData['name'] ?? 'User Name';
            email.value = userData['email'] ?? 'User Email';
            profileImage.value = userData['avatar'] ?? '';
            city.value = userData['city'] ?? 'Not specified';
            dob.value = userData['dob'] ?? 'Not specified';
            gender.value = userData['gender'] ?? 'Not specified';
            mobile.value = userData['mobile'] ?? 'Not specified';
            state.value = userData['state'] ?? 'Not specified';

            if (profileImage.value.isNotEmpty) {
              final bytes = base64Decode(profileImage.value);
              profileImageBytes.value = bytes;
            }

            return userData;
          } else {
            errorMessage.value = "No user data found.";
            return {};
          }
        });
      } else {
        errorMessage.value = "User not logged in.";
        return Stream.value({});
      }
    } catch (e) {
      errorMessage.value = e.toString();
      return Stream.value({});
    }
  }

  Future<void> selectAndUploadImage(BuildContext context) async {
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet(
      backgroundColor: AppConst.coolMintColor,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library, color: AppConst.primaryColor),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    color: AppConst.primaryColor,
                    fontFamily: AppConst.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
                onTap: () async {
                  await pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera, color: AppConst.primaryColor),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    color: AppConst.primaryColor,
                    fontFamily: AppConst.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
                onTap: () async {
                  await pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> compressImageToBase64(File imageFile) async {
    final bytes = imageFile.readAsBytesSync();

    img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 600);
      final compressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 50));
      if (compressedBytes.lengthInBytes > 1048576) {
        final furtherCompressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 30));
        return base64Encode(furtherCompressedBytes);
      }
      return base64Encode(compressedBytes);
    } else {
      throw Exception("Failed to decode image");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final compressedBase64Image = await compressImageToBase64(File(pickedFile.path));
        await updateImageInFirestore(compressedBase64Image);
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final compressedBase64Image = await compressImageToBase64(File(pickedFile.path));
        await updateImageInFirestore(compressedBase64Image);
      }
    } catch (e) {
      print("Error picking image from camera: $e");
    }
  }

  Future<void> updateImageInFirestore(String base64String) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({'avatar': base64String});
        profileImage.value = base64String;
        profileImageBytes.value = base64Decode(base64String);

        print("Image stored in Firestore successfully.");
      } else {
        print("User not logged in.");
      }
    } catch (e) {
      print("Error storing image in Firestore: $e");
    }
  }

  void showEditDialog(String fieldKey, String currentValue ,BuildContext context) {
    final TextEditingController textController = TextEditingController(text: currentValue);
    Get.dialog(
      AlertDialog(
        title: const Text("Edit The Details"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              String newValue = textController.text.trim();
              if (newValue.isNotEmpty) {
                updateUserData({fieldKey: newValue},context);
              }
              Get.back();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)), 
        firstDate: DateTime(1900), 
        lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)), 
      );

      if (pickedDate != null) {
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        await updateUserData({'dob': formattedDate},context);
        dob.value = formattedDate;
        Get.snackbar('Success', 'Date of birth updated successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick date: $e');
    }
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }



  Future<void> updateUserData(Map<String, dynamic> updatedData,BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update(updatedData);

        ToastService.showToast(
          context,
          leading: Icon(Icons.done_outline_rounded,color: AppConst.coolMintColor,),
          backgroundColor: AppConst.primaryColor,
          messageStyle: TextStyle(color: AppConst.coolMintColor,fontFamily: AppConst.medium),
          message: "Profile updated successfully!",
          length: ToastLength.medium,
          shadowColor: AppConst.secoundaryColor,
          positionCurve: Curves.bounceOut,
          slideCurve: Curves.elasticInOut,
        );
      } else {
        ToastService.showErrorToast(
          context,
          message: "User not logged in.",
          length: ToastLength.medium,
          positionCurve: Curves.bounceOut,
          slideCurve: Curves.elasticInOut,
        );
      }
    } catch (e) {
      ToastService.showErrorToast(
        context,
        message: e.toString(),
        length: ToastLength.medium,
        positionCurve: Curves.bounceOut,
        slideCurve: Curves.elasticInOut,
      );
    }
  }

  Widget buildProfileField({
    required BuildContext context,
    required IconData icon,
    // required String title,
    required String value,
    required String fieldKey,
    bool editable = true,
  }) {
    return GestureDetector(
      onTap: editable
          ? () => showEditDialog(fieldKey, value,context!)
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppConst.primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                " $value",
                style:  TextStyle(fontSize: 16, color: AppConst.primaryColor,fontWeight: FontWeight.bold),
              ),
            ),
            if (editable)
              Icon(Icons.edit, size: 20, color: AppConst.primaryColor),
          ],
        ),
      ),
    );
  }
}
