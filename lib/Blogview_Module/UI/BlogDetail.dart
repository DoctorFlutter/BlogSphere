import 'package:blogsphere/BlogFunctionallity_Module/Controller/blog_controller.dart';
import 'package:blogsphere/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BlogDetail extends GetView<BlogController> {
  final Map<String, dynamic> blog;
  final TextEditingController _commentController = TextEditingController();

  BlogDetail({required this.blog});

  @override
  Widget build(BuildContext context) {
    final String blogId = blog['blogId'] ?? '';
    final String userId = Get.find<AuthController>().user?.uid ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(blog['title'] ?? 'Blog Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(blog['content'] ?? 'No content available', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (blog['likes']?.contains(userId) ?? false) {
                      controller.unlikeBlog(blogId, userId);
                    } else {
                      controller.likeBlog(blogId, userId);
                    }
                  },
                  icon: Icon(
                    blog['likes']?.contains(userId) ?? false
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                    color: Colors.blue,
                  ),
                ),
                Text('${blog['likes']?.length ?? 0} Likes'),
              ],
            ),
            SizedBox(height: 20),
            Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: blog['comments']?.length ?? 0,
                itemBuilder: (context, index) {
                  final comment = blog['comments'][index];
                  return ListTile(
                    title: Text(comment['comment'] ?? 'No comment'),
                    subtitle: Text(comment['userId'] ?? 'Unknown user'),
                  );
                },
              ),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      controller.addComment(blogId, userId, _commentController.text.trim());
                      _commentController.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}