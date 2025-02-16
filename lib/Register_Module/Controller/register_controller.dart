import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:blogsphere/Custom_Widget/Toast/toast_service.dart';
import 'package:blogsphere/Register_Module/Database/register_database.dart';
import 'package:blogsphere/Register_Module/Models/register_model.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import "package:image_picker/image_picker.dart";
import 'package:intl/intl.dart';
import '../../App_const.dart';
import '../../Custom_Widget/Toast/toast_enums.dart';
import 'package:image/image.dart' as img;
class RegisterController extends GetxController{
  Rx<File?> profileImage = Rx<File?>(null);
  Rx<bool> isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();
  RxString selectedDate = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedState = ''.obs;
  RxString selectedCity = ''.obs;
  RxBool isGenderValid = true.obs;
  RxBool isUnderage = false.obs;
  RxBool isRememberMeChecked = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isconfPasswordVisible = false.obs;

  Rx<TextEditingController> namecontroller = TextEditingController().obs;
  Rx<TextEditingController> mobilecontroller = TextEditingController().obs;
  Rx<TextEditingController> statecontroller = TextEditingController().obs;
  Rx<TextEditingController> citycontroller = TextEditingController().obs;
  Rx<TextEditingController> dobcontroller = TextEditingController().obs;
  Rx<TextEditingController> emailcontroller = TextEditingController().obs;
  Rx<TextEditingController> passcontroller = TextEditingController().obs;
  Rx<TextEditingController> confirmpasscontroller = TextEditingController().obs;

  Rx<FocusNode> nameFocusNode = FocusNode().obs;
  Rx<FocusNode> mobileFocusNode = FocusNode().obs;
  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> passFocusNode = FocusNode().obs;
  Rx<FocusNode> conformpassFocusNode = FocusNode().obs;
  Rx<FocusNode> stateFocusNode = FocusNode().obs;
  Rx<FocusNode> cityFocusNode = FocusNode().obs;
  Rx<FocusNode> dobFocusNode = FocusNode().obs;

  Uint8List? fileBytes;
  RxString base64Image = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  RegisterDatabase db = RegisterDatabase();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleconfPasswordVisibility() {
    isconfPasswordVisible.value = !isconfPasswordVisible.value;
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(pickedDate);
      final age = _calculateAge(pickedDate);
      isUnderage.value = age < 18;
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
  // final List<String> states = [
  //   'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana',
  //   'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur',
  //   'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana',
  //   'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Andaman and Nicobar Islands', 'Chandigarh',
  //   'Dadra and Nagar Haveli', 'Lakshadweep', 'Delhi', 'Puducherry'
  // ];
  //
  // final Map<String, List<String>> cities = {
  //   'Andhra Pradesh': [
  //     'Visakhapatnam', 'Vijayawada', 'Guntur', 'Tirupati', 'Kurnool', 'Anantapur', 'Nellore', 'Rajahmundry', 'Eluru', 'Chittoor'
  //   ],
  //   'Arunachal Pradesh': [
  //     'Itanagar', 'Tawang', 'Naharlagun', 'Ziro', 'Pasighat', 'Bomdila', 'Tezu'
  //   ],
  //   'Assam': [
  //     'Guwahati', 'Jorhat', 'Dibrugarh', 'Silchar', 'Nagaon', 'Tinsukia', 'Bongaigaon', 'Tezpur', 'Diphu'
  //   ],
  //   'Bihar': [
  //     'Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur', 'Munger', 'Purnia', 'Begusarai', 'Nalanda', 'Chapra', 'Arrah'
  //   ],
  //   'Chhattisgarh': [
  //     'Raipur', 'Bilaspur', 'Korba', 'Durg', 'Raigarh', 'Jagdalpur', 'Dhamtari', 'Rajnandgaon'
  //   ],
  //   'Goa': [
  //     'Panaji', 'Margao', 'Vasco da Gama', 'Mapusa', 'Ponda', 'Quepem', 'Bicholim', 'Cortalim'
  //   ],
  //   'Gujarat': [
  //     'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Jamnagar', 'Junagadh', 'Anand', 'Valsad', 'Navsari'
  //   ],
  //   'Haryana': [
  //     'Chandigarh', 'Gurugram', 'Faridabad', 'Hisar', 'Ambala', 'Panipat', 'Karnal', 'Sonipat', 'Yamunanagar', 'Rohtak'
  //   ],
  //   'Himachal Pradesh': [
  //     'Shimla', 'Manali', 'Dharamshala', 'Kullu', 'Solan', 'Kangra', 'Bilaspur', 'Mandi', 'Chamba'
  //   ],
  //   'Jharkhand': [
  //     'Ranchi', 'Jamshedpur', 'Dhanbad', 'Bokaro', 'Deoghar', 'Hazaribagh', 'Giridih', 'Chaibasa', 'Dumka', 'Ramgarh'
  //   ],
  //   'Karnataka': [
  //     'Bangalore', 'Mysore', 'Hubli', 'Mangalore', 'Belgaum', 'Tumkur', 'Davangere', 'Shimoga', 'Bagalkot', 'Chikmagalur'
  //   ],
  //   'Kerala': [
  //     'Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Kottayam', 'Thrissur', 'Malappuram', 'Alappuzha', 'Palakkad', 'Kannur', 'Idukki'
  //   ],
  //   'Madhya Pradesh': [
  //     'Bhopal', 'Indore', 'Gwalior', 'Ujjain', 'Jabalpur', 'Sagar', 'Ratlam', 'Dewas', 'Shivpuri', 'Mandsaur'
  //   ],
  //   'Maharashtra': [
  //     'Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad', 'Solapur', 'Thane', 'Nanded', 'Kolhapur', 'Satara'
  //   ],
  //   'Manipur': [
  //     'Imphal', 'Thoubal', 'Churachandpur', 'Kangpokpi', 'Tamenglong'
  //   ],
  //   'Meghalaya': [
  //     'Shillong', 'Tura', 'Jowai', 'Nongpoh', 'Williamnagar'
  //   ],
  //   'Mizoram': [
  //     'Aizawl', 'Lunglei', 'Champhai', 'Kolasib', 'Serchhip'
  //   ],
  //   'Nagaland': [
  //     'Kohima', 'Dimapur', 'Mokokchung', 'Wokha', 'Zunheboto'
  //   ],
  //   'Odisha': [
  //     'Bhubaneswar', 'Cuttack', 'Berhampur', 'Rourkela', 'Sambalpur', 'Balasore', 'Bargarh', 'Puri', 'Koraput', 'Angul'
  //   ],
  //   'Punjab': [
  //     'Amritsar', 'Ludhiana', 'Patiala', 'Jalandhar', 'Mohali', 'Bathinda', 'Hoshiarpur', 'Moga', 'Firozpur', 'Kapurthala'
  //   ],
  //   'Rajasthan': [
  //     'Jaipur', 'Udaipur', 'Jodhpur', 'Ajmer', 'Kota', 'Bikaner', 'Alwar', 'Sikar', 'Churu', 'Tonk'
  //   ],
  //   'Sikkim': [
  //     'Gangtok', 'Namchi', 'Rangpo', 'Mangan'
  //   ],
  //   'Tamil Nadu': [
  //     'Chennai', 'Coimbatore', 'Madurai', 'Trichy', 'Salem', 'Tirunelveli', 'Erode', 'Vellore', 'Chidambaram', 'Tiruppur'
  //   ],
  //   'Telangana': [
  //     'Hyderabad', 'Warangal', 'Khammam', 'Nizamabad', 'Karimnagar', 'Ramagundam', 'Mahabubnagar', 'Adilabad'
  //   ],
  //   'Tripura': [
  //     'Agartala', 'Udaipur', 'Dharmanagar', 'Belonia', 'Ambassa'
  //   ],
  //   'Uttar Pradesh': [
  //     'Lucknow', 'Kanpur', 'Agra', 'Varanasi', 'Allahabad', 'Gorakhpur', 'Meerut', 'Noida', 'Bareilly', 'Aligarh'
  //   ],
  //   'Uttarakhand': [
  //     'Dehradun', 'Haridwar', 'Nainital', 'Rishikesh', 'Roorkee', 'Haldwani', 'Mussoorie', 'Pauri', 'Kashipur'
  //   ],
  //   'West Bengal': [
  //     'Kolkata', 'Siliguri', 'Howrah', 'Asansol', 'Durgapur', 'Midnapore', 'Kharagpur', 'Murshidabad', 'Malda', 'Hooghly'
  //   ],
  //   'Andaman and Nicobar Islands': [
  //     'Port Blair', 'Car Nicobar', 'Mayabunder', 'Diglipur', 'Havelock'
  //   ],
  //   'Chandigarh': [
  //     'Chandigarh'
  //   ],
  //   'Dadra and Nagar Haveli': [
  //     'Daman', 'Diu'
  //   ],
  //   'Lakshadweep': [
  //     'Kavaratti'
  //   ],
  //   'Delhi': [
  //     'New Delhi', 'Old Delhi', 'Janakpuri', 'Connaught Place', 'Chandni Chowk', 'Saket', 'Vasant Vihar'
  //   ],
  //   'Puducherry': [
  //     'Puducherry', 'Auroville', 'Karaikal', 'Mahe', 'Yanam'
  //   ]
  // };

  // List<String> getCities(String state) {
  //   return cities[state] ?? [];
  // }

  // void convertImageToBase64(File imageFile) {
  //   final bytes = imageFile.readAsBytesSync();
  //   img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
  //
  //   if (image != null) {
  //     img.Image resizedImage = img.copyResize(image, width: 600);
  //     final resizedBytes = Uint8List.fromList(img.encodeJpg(resizedImage));
  //
  //     base64Image.value = base64Encode(resizedBytes);
  //     log("Encoded Resized Image: ${base64Image.value}");
  //   } else {
  //     log("Failed to decode image.");
  //   }
  // }

  void compressAndConvertImageToBase64(File imageFile) async {
    final bytes = imageFile.readAsBytesSync();
    img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 600);
      final compressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 50));
      if (compressedBytes.lengthInBytes > 1048576) {
        log("Compressed image is still too large, reducing further.");
        final furtherCompressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 30));
        base64Image.value = base64Encode(furtherCompressedBytes);
      } else {
        base64Image.value = base64Encode(compressedBytes);
      }
      log("Encoded Compressed Image: ${base64Image.value}");
    } else {
      log("Failed to decode image.");
    }
  }



  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
      compressAndConvertImageToBase64(profileImage.value!);
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
      compressAndConvertImageToBase64(profileImage.value!);
    }
  }

  // void convertImageToBase64(File imageFile) {
  //   final bytes = imageFile.readAsBytesSync();
  //   base64Image.value = base64Encode(bytes);
  //   log("Encoded Image: ${base64Image.value}");
  // }

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
                leading:  Icon(Icons.photo_library,color: AppConst.primaryColor,),
                title:  Text('Gallery',style: TextStyle(color: AppConst.primaryColor,fontFamily: AppConst.bold,fontSize: size.width * 0.04),),
                onTap: () async {
                  await pickImageFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading:  Icon(Icons.photo_camera,color: AppConst.primaryColor,),
                title:  Text('Camera',style: TextStyle(color: AppConst.primaryColor,fontFamily: AppConst.bold,fontSize: size.width * 0.04),),
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



  Future<void> registerUser(context) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailcontroller.value.text,
        password: passcontroller.value.text,
      );

      await db.addUser(data: RegisterModel(
          name: namecontroller.value.text,
          dob: selectedDate.value,
          gender: selectedGender.value,
          mobile: mobilecontroller.value.text,
          email: emailcontroller.value.text,
          // state: selectedState.value,
          // city: selectedCity.value,
          avatar: base64Image.value,
          docID: _auth.currentUser!.uid.toString(),
      ));
        Get.offAllNamed(AppRoutes.loginscreen);
      showCustomToast(context: context,errorMessage: "User registered successfully");
    } on FirebaseAuthException catch (e) {
      showCustomToast(
          context: context, errorMessage: e.message ?? 'An error occurred');
    }
    catch (e) {
      log("Email: ${emailcontroller.value.text}");
      log('Mobile: ${mobilecontroller.value.text}');
      log('Name: ${namecontroller.value.text}');
      log('dob: ${dobcontroller.value.text}');
      log('Name: ${dobcontroller.value.text}');
      ToastService.showErrorToast(
        context,
        message: e.toString(),
        length: ToastLength.medium,
        positionCurve: Curves.bounceOut,
        slideCurve: Curves.elasticInOut,
      );
    }finally{
      isLoading.value = false;
    }
  }

  void register_Validator(context){
    String? errorMessage;
    if (profileImage.value?.path.isEmpty ?? true) {
      errorMessage = "Please upload a profile image";
      showCustomToast(context: context,errorMessage: errorMessage);
    } else if(namecontroller.value.text.isEmpty){
      errorMessage = "Please Enter Your Name";
      nameFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(selectedDate.value.isEmpty){
      errorMessage = "Please Enter Your DOB";
      dobFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(selectedGender.value.isEmpty){
      errorMessage = "Please select Gender";
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(mobilecontroller.value.text.isEmpty){
      errorMessage = "Please Enter Your Mobile Number";
      mobileFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(emailcontroller.value.text.isEmpty){
      errorMessage = "Please Enter Your Email Address";
      emailFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(!RegExp(AppConst.emailregexp).hasMatch(emailcontroller.value.text)){
      errorMessage = "Please Enter Valid Email Address";
      emailFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(passcontroller.value.text.isEmpty) {
      errorMessage = "Please Enter Your Password";
      passFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(!RegExp(AppConst.passregexp).hasMatch(passcontroller.value.text)){
      errorMessage = "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character";
      passFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(confirmpasscontroller.value.text.isEmpty){
      errorMessage = "Please Enter Your Confirm Password";
      conformpassFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else if(confirmpasscontroller.value.text != passcontroller.value.text){
      errorMessage = "Password And Confirm Password Not Match";
      conformpassFocusNode.value.requestFocus();
      showCustomToast(context: context,errorMessage: errorMessage);
    }else{
      registerUser(context);
    }
  }

  void showCustomToast({
    required BuildContext context,
    required String errorMessage,
  }) {
    ToastService.showToast(
      context,
      leading: Icon(Icons.error_outline_rounded,color: AppConst.coolMintColor,),
      backgroundColor: AppConst.primaryColor,
      messageStyle: TextStyle(color: AppConst.coolMintColor,fontFamily: AppConst.medium),
      message: errorMessage,
      length: ToastLength.medium,
      shadowColor: AppConst.secoundaryColor,
      positionCurve: Curves.bounceOut,
      slideCurve: Curves.elasticInOut,
    );
  }


  @override
  void dispose() {
    nameFocusNode.value.dispose();
    mobileFocusNode.value.dispose();
    emailFocusNode.value.dispose();
    passFocusNode.value.dispose();
    conformpassFocusNode.value.dispose();
    stateFocusNode.value.dispose();
    cityFocusNode.value.dispose();
    dobFocusNode.value.dispose();
    super.dispose();
  }
}
