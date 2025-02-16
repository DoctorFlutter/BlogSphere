import 'package:blogsphere/Register_Module/Models/register_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterDatabase {
  static final RegisterDatabase _databaseInstance = RegisterDatabase._();

  factory RegisterDatabase() {
    return _databaseInstance;
  }

  RegisterDatabase._();

  Future<bool> addUser({required RegisterModel data}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(data.toMap());
        return true;
      } else {
        print("No authenticated user found.");
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  Stream<QuerySnapshot> listenUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots();
  }
}
