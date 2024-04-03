import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/model/usermodel.dart';

class SearchControllerCustom {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUserModel(String userModelTyped) {
    return _firebaseFirestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: userModelTyped)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((doc) => UserModel.fromSnap(doc)).toList();
    });
  }
}
