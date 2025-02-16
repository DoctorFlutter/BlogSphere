import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<void> likeBlog(String blogId, String userId) async {
    await _firestore.collection('blogs').doc(blogId).update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  
  Future<void> unlikeBlog(String blogId, String userId) async {
    await _firestore.collection('blogs').doc(blogId).update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  }

  Stream<QuerySnapshot> getBlogs() {
    return _firestore.collection('blogs').orderBy('timestamp', descending: true).snapshots();
  }
  Future<void> addComment(String blogId, String userId, String comment) async {
    await _firestore.collection('blogs').doc(blogId).update({
      'comments': FieldValue.arrayUnion([
        {
          'userId': userId,
          'comment': comment,
          'timestamp': DateTime.now(),
        }
      ]),
    });
  }
}