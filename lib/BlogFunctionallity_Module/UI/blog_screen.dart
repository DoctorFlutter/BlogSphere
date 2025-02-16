import 'package:blogsphere/BlogFunctionallity_Module/Controller/blog_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogScreen extends GetView<BlogController> {
  BlogScreen({Key? key}) : super(key: key);

  // Initialize the controller
  final BlogController controller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title TextField
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Content TextField
            TextField(
              controller: controller.contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),

            // Publish Blog Button
            ElevatedButton(
              onPressed: () async {
                // Validate input fields
                if (controller.titleController.text.trim().isEmpty ||
                    controller.contentController.text.trim().isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please fill in both title and content',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                // Prepare blog data
                final blogData = {
                  'blogId': DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
                  'title': controller.titleController.text.trim(),
                  'content': controller.contentController.text.trim(),
                  'likes': 0,
                  'likedBy': [],
                  'comments': [],
                  'timestamp': FieldValue.serverTimestamp(),
                };

                // Add blog to Firestore
                await controller.addBlog(blogData);

                // Clear text fields after publishing
                controller.titleController.clear();
                controller.contentController.clear();

                // Show success message
                Get.snackbar(
                  'Success',
                  'Blog published successfully!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );

                // Navigate back
                Get.back();
              },
              child: Text('Publish Blog'),
            ),
          ],
        ),
      ),
    );
  }
}