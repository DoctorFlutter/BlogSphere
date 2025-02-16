import 'dart:math';

import 'package:blogsphere/App_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class BottomNavigationController extends GetxController with SingleGetTickerProviderMixin {
  RxInt currentIndex = 0.obs;
  // bool isDialogOpen = false;
  // RxString selectedWorkExperience = ''.obs;
  // Rx<TextEditingController> skillInputController = TextEditingController().obs;
  // Rx<TextEditingController> jobTitle = TextEditingController().obs;
  // Rx<TextEditingController> jobDiscription = TextEditingController().obs;
  // final workExperienceOptions = ['Fresher', '1-2 Years', '2+ Years'];
  // List<String> skills = <String>[].obs;
  // final List<String> predefinedSkills = [
  //   'Python', 'Java', 'C++', 'JavaScript', 'Dart', 'Flutter', 'React', 'Node.js', 'SQL', 'NoSQL'
  // ];
  // var jobRequirements = <Map<String, String>>[].obs;
  //
  // final GetStorage _storage = GetStorage();
  //
  // @override
  // void onInit() {
  //   // loadJobRequirements();
  //   super.onInit();
  // }

  void changePage(int index) {
    currentIndex.value = index;
  }

  // void addSkill() {
  //   String skill = skillInputController.value.text;
  //   if (skill.isNotEmpty && !skills.contains(skill)) {
  //     skills.add(skill);
  //     skillInputController.value.clear();
  //   }
  // }
  //
  // void removeSkill(String skill) {
  //   skills.remove(skill);
  // }
  //
  // void clear() {
  //   skillInputController.value.clear();
  //   skills.clear();
  //   jobTitle.value.clear();
  //   jobDiscription.value.clear();
  //   selectedWorkExperience.value = '';
  // }
  //
  // void storeJobRequirement() {
  //   String title = jobTitle.value.text;
  //   String description = jobDiscription.value.text;
  //   String workExperience = selectedWorkExperience.value;
  //   String skillsText = skills.isEmpty ? 'No skills added' : skills.join(', ');
  //
  //   if (title.isEmpty || description.isEmpty || workExperience.isEmpty) {
  //     Get.snackbar('Error', 'Please fill all required fields.');
  //     return;
  //   }
  //
  //   Map<String, String> jobRequirement = {
  //     'title': title,
  //     'description': description,
  //     'workExperience': workExperience,
  //     'skills': skillsText,
  //   };
  //
  //   // Add new requirement to the list
  //   jobRequirements.add(jobRequirement);
  //
  //   // Log the jobRequirements list before storing it
  //   print("Job Requirements before storing: ${jobRequirements.toString()}");
  //
  //   // Store in GetStorage
  //   _storage.write('jobRequirements', jobRequirements.toList()); // Ensure it is a List
  //
  //   // Refresh the UI by reloading the requirements
  //   loadJobRequirements(); // This will trigger the UI to update
  //
  //   // Log the jobRequirements list after loading it
  //   print("Job Requirements after loading: ${jobRequirements.toString()}");
  // }
  //
  //
  //
  // void loadJobRequirements() {
  //   var storedRequirements = _storage.read<List<dynamic>>('jobRequirements');
  //   print("Stored Job Requirements: $storedRequirements");
  //   if (storedRequirements != null) {
  //     jobRequirements.value = storedRequirements.map((item) => Map<String, String>.from(item)).toList();
  //     print("Loaded Job Requirements: ${jobRequirements.toString()}");
  //   }
  // }
  //
  // void logStoredData() {
  //   var storedData = _storage.read<List<dynamic>>('jobRequirements');
  //   if (storedData != null) {
  //     print('Stored Job Requirements:');
  //     storedData.forEach((item) {
  //       print(Map<String, String>.from(item));
  //     });
  //   } else {
  //     print('No job requirements found in storage.');
  //   }
  // }

  // void showAddRequirementDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Add New Requirement',
  //           style: TextStyle(
  //             color: AppConst.primaryColor,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: AppConst.regular,
  //           ),
  //         ),
  //         content: Container(
  //           width: MediaQuery.of(context).size.width * 0.9, // Set the desired width here
  //           padding: const EdgeInsets.all(15.0),
  //           child: SingleChildScrollView(
  //             child: ConstrainedBox(
  //               constraints: BoxConstraints(
  //                 maxHeight: Get.height * 0.8, // Adjust max height to prevent overflow
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       border: Border(bottom: BorderSide(color: AppConst.grayScale, width: 1.8)),
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           child: TextFormField(
  //                             keyboardType: TextInputType.text,
  //                             style: TextStyle(color: AppConst.primaryColor),
  //                             controller: jobTitle.value,
  //                             decoration: InputDecoration(
  //                               border: InputBorder.none,
  //                               hintText: 'Enter Job Title',
  //                               hintStyle: TextStyle(color: AppConst.text_Color),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Obx(
  //                         () => Container(
  //                       height: 50,
  //                       decoration: BoxDecoration(
  //                         border: Border(bottom: BorderSide(color: AppConst.grayScale, width: 1.8)),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Expanded(
  //                             child: DropdownButtonFormField<String>(
  //                               icon: Padding(
  //                                 padding: const EdgeInsets.only(right: 10.0, bottom: 80),
  //                                 child: Icon(Icons.keyboard_arrow_down_outlined, size: 30, color: AppConst.iconColor),
  //                               ),
  //                               value: selectedWorkExperience.value.isEmpty ? null : selectedWorkExperience.value,
  //                               decoration: InputDecoration(
  //                                 border: InputBorder.none,
  //                                 hintText: 'Work Experience',
  //                                 hintStyle: TextStyle(color: AppConst.text_Color),
  //                               ),
  //                               items: workExperienceOptions.map((String value) {
  //                                 return DropdownMenuItem<String>(
  //                                   value: value,
  //                                   child: Text(value),
  //                                 );
  //                               }).toList(),
  //                               onChanged: (newValue) {
  //                                 selectedWorkExperience.value = newValue!;
  //                               },
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 20),
  //                   Column(
  //                     children: [
  //                       Container(
  //                         height: 50,
  //                         decoration: BoxDecoration(
  //                           border: Border(bottom: BorderSide(color: AppConst.grayScale, width: 1.8)),
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: TypeAheadField<String>(
  //                                     suggestionsCallback: (pattern) {
  //                                       return predefinedSkills.where(
  //                                             (skill) => skill.toLowerCase().contains(pattern.toLowerCase()) && !skills.contains(skill),
  //                                       ).toList();
  //                                     },
  //                                     itemBuilder: (context, suggestion) {
  //                                       return ListTile(
  //                                         title: Text(suggestion),
  //                                       );
  //                                     },
  //                                     onSuggestionSelected: (suggestion) {
  //                                       skillInputController.value.text = suggestion;
  //                                       addSkill();
  //                                     },
  //                                     textFieldConfiguration: TextFieldConfiguration(
  //                                       controller: skillInputController.value,
  //                                       decoration: InputDecoration(
  //                                         border: InputBorder.none,
  //                                         hintText: 'Add Require Skills',
  //                                         hintStyle: TextStyle(
  //                                           color: AppConst.text_Color,
  //                                         ),
  //                                         suffixIcon: IconButton(
  //                                           onPressed: addSkill,
  //                                           icon: Icon(Icons.add, color: AppConst.iconColor),
  //                                         ),
  //                                       ),
  //                                       onSubmitted: (value) {
  //                                         addSkill();
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       const SizedBox(height: 10),
  //                       Obx(
  //                             () => Wrap(
  //                           spacing: 5.0,
  //                           children: skills.map((skill) {
  //                             return InputChip(
  //                               label: Text(
  //                                 skill,
  //                                 style: const TextStyle(color: AppConst.white),
  //                               ),
  //                               deleteIcon: Container(
  //                                 width: 100,
  //                                 height: 100,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(50),
  //                                   border: Border.all(
  //                                     color: Colors.white,
  //                                     width: 2,
  //                                   ),
  //                                 ),
  //                                 child: const Icon(
  //                                   Icons.close,
  //                                   color: Colors.white,
  //                                   size: 15,
  //                                 ),
  //                               ),
  //                               onDeleted: () => removeSkill(skill),
  //                               backgroundColor: AppConst.primaryColor,
  //                             );
  //                           }).toList(),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   TextField(
  //                     maxLines: 5,
  //                     controller: jobDiscription.value,
  //                     style: const TextStyle(color: Colors.black, fontSize: 15),
  //                     decoration: InputDecoration(
  //                       hintText: 'Job Description',
  //                       hintStyle: TextStyle(color: AppConst.text_Color),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   Get.back();
  //                   isDialogOpen = false;
  //                   clear();
  //                 },
  //                 child: Container(
  //                   width: 90,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                     border: Border.all(width: 2, color: AppConst.primaryColor),
  //                     borderRadius: BorderRadius.circular(15),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       "Cancel",
  //                       style: TextStyle(
  //                         color: AppConst.primaryColor,
  //                         fontFamily: AppConst.bold,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(width: 5),
  //               GestureDetector(
  //                 onTap: () {
  //                   // storeJobRequirement();
  //                   Get.back();
  //                   isDialogOpen = false;
  //                   clear();
  //                 },
  //                 child: Container(
  //                   width: 90,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                     color: AppConst.primaryColor,
  //                     borderRadius: BorderRadius.circular(15),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       "Submit",
  //                       style: TextStyle(
  //                         color: AppConst.white,
  //                         fontFamily: AppConst.bold,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
