import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String profilePics;
  String email;
  String uid;

  UserModel(
      {required this.name,
      required this.profilePics,
      required this.email,
      required this.uid});

  Map<String, dynamic> toJson() =>
      {"name": name, "profilePics": profilePics, "email": email, "uid": uid};

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        name: snapshot["name"],
        profilePics: snapshot["profilePics"],
        email: snapshot["email"],
        uid: snapshot["uid"]);
  }
}
