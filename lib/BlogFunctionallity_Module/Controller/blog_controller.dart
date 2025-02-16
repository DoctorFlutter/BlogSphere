import 'package:blogsphere/Home_Module/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TextEditingControllers for the blog form
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // Method to add a blog to Firestore
  Future<void> addBlog(Map<String, dynamic> blogData) async {
    try {
      await _firestore.collection('blogs').add(blogData);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to publish blog: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    // Dispose of the controllers when the controller is closed
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}