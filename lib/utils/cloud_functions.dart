import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/storage.dart';

class CloudFunctions {
  //static instance of firebase
  static final firebaseInstance = FirebaseFirestore.instance;

  //collection references
  static final CollectionReference users = firebaseInstance.collection('users');


  //add user to users-collection
  Future<void> registerUser(String uid, String email, String userName) async {
    Map<String, dynamic> userMap = {
      'uid': uid,
      'email': email,
      'userName': userName
    };
    await users.doc(uid).set(userMap);
  }

  //get user details
  Future<DocumentSnapshot> getUserDetail(String uid) async {
    var a=await users.doc(uid).get();
    return a;
  }
}
