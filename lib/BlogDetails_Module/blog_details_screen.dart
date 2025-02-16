import 'package:blogsphere/App_const.dart';
import 'package:flutter/material.dart';
import 'package:blogsphere/Home_Module/Model/BlogModel.dart';

class BlogDetailsScreen extends StatelessWidget {
  final BlogModel blog;

  BlogDetailsScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                blog.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: AppConst.primaryColor,),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              blog.content,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}