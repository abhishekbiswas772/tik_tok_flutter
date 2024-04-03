import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/model/usermodel.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? imagePicked;
  String? fileURlImage;
  Stream<User?> get getAuthChange => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  Future<File?> picImageFuncs() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagePicked = File(pickedImage.path);
      return imagePicked;
    } else {
      return null;
    }
  }

  Future<String> _uploadToStore(File image) async {
    Reference ref = _firebaseStorage
        .ref()
        .child('profilePics')
        .child(_auth.currentUser?.uid ?? "");
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  Future<bool> performRegisterUser(
      String username, String password, File? image, String email) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadURL = await _uploadToStore(image);
        UserModel userModel = UserModel(
            name: username,
            profilePics: downloadURL,
            email: email,
            uid: _auth.currentUser?.uid ?? "");
        await _firebaseFirestore
            .collection('users')
            .doc(userCredential.user?.uid ?? "")
            .set(userModel.toJson());
        fileURlImage = downloadURL;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> performLoginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
