import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterModel {
  String name;
  String dob;
  String gender;
  String mobile;
  String email;
  // String state;
  // String city;
  String? avatar;
  String? docID;

  RegisterModel({
    required this.name,
    required this.dob,
    required this.gender,
    required this.mobile,
    required this.email,
    // required this.state,
    // required this.city,
    this.avatar,
    this.docID,
  });

  factory RegisterModel.fromFirestore(DocumentSnapshot doc){
    Map? data = doc.data() as Map?;
    return RegisterModel(
        name: data!['name'],
        dob: data['dob'],
        gender: data['gender'],
        mobile: data['mobile'],
        email: data['email'],
        // state: data['state'],
        // city: data['city'],
        avatar: data['avatar'],
        docID: doc.id,
    );
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = {
      'name' : name,
      'dob' : dob,
      'gender' : gender,
      'mobile' : mobile,
      'email' : email,
      // 'state' : state,
      // 'city' : city,
      'avatar': avatar,
      'docID' : docID
    };
    return data;
  }

}