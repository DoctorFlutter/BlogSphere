import 'package:blogsphere/App_const.dart';
import 'package:blogsphere/Home_Module/Controller/home_controller.dart';
import 'package:blogsphere/Home_Module/Model/BlogModel.dart';
import 'package:blogsphere/Routes/page_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  HomeController controller = Get.put(HomeController());
  String userId = "user123"; // Replace with actual user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
        backgroundColor: AppConst.primaryColor,
        elevation: 0,
      ),
      backgroundColor: AppConst.whiteColor,
      body: Obx(() {
        if (controller.blogs.isEmpty) {
          return Center(child: Text("No blogs available"));
        }
        return ListView.builder(
          itemCount: controller.blogs.length,
          itemBuilder: (context, index) {
            BlogModel blog = controller.blogs[index];
            bool isLiked = blog.likedBy.contains(userId);
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      blog.content,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.thumb_up,
                                color: isLiked ? Colors.blue : Colors.grey,
                              ),
                              onPressed: isLiked
                                  ? null
                                  : () => controller.likeBlog(blog.blogId, userId),
                            ),
                            Text("${blog.likes} Likes"),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.comment, color: Colors.grey),
                          onPressed: () => showCommentDialog(context, blog.blogId),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Comments:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...blog.comments.map((comment) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "- ${comment.comment}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "by ${comment.userId}",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConst.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.toNamed(AppRoutes.blogscreen);
        },
      ),
    );
  }

  void showCommentDialog(BuildContext context, String blogId) {
    TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add a comment"),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: "Enter your comment"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Get.back(),
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  controller.addComment(blogId, userId, commentController.text);
                  Get.back();
                }
              },
            ),
          ],
        );
      },
    );
  }
}