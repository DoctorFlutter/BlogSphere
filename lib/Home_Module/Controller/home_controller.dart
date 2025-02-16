import 'package:blogsphere/Home_Module/Model/BlogModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var blogs = <BlogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
  }

  void fetchBlogs() async {
    firestore.collection('blogs').orderBy('timestamp', descending: true).snapshots().listen((snapshot) {
      blogs.value = snapshot.docs.map((doc) => BlogModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  void likeBlog(String blogId, String userId) async {
    var blogRef = firestore.collection('blogs').doc(blogId);
    var blogDoc = await blogRef.get();
    if (blogDoc.exists) {
      List<dynamic> likedBy = blogDoc['likedBy'] ?? [];
      if (!likedBy.contains(userId)) {
        int currentLikes = blogDoc['likes'] ?? 0;
        await blogRef.update({
          'likes': currentLikes + 1,
          'likedBy': FieldValue.arrayUnion([userId]),
        });


        int blogIndex = blogs.indexWhere((blog) => blog.blogId == blogId);
        if (blogIndex != -1) {
          BlogModel updatedBlog = blogs[blogIndex].copyWith(
            likes: currentLikes + 1,
            likedBy: List.from(likedBy)..add(userId),
          );
          blogs[blogIndex] = updatedBlog;
        }
      }
    }
  }

  void addComment(String blogId, String userId, String comment) async {
    var blogRef = firestore.collection('blogs').doc(blogId);
    await blogRef.update({
      'comments': FieldValue.arrayUnion([
        {
          'userId': userId,
          'comment': comment,
          'timestamp': FieldValue.serverTimestamp(),
        }
      ]),
    });
  }
}