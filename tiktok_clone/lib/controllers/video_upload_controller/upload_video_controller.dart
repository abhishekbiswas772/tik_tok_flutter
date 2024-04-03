import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';
import 'package:tiktok_clone/model/video_model.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController {
  final AuthController _authController = AuthController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<VideoModel?> uploadVideo(
      String songName, String caption, String videoPath) async {
    try {
      String uid = _authController.user?.uid ?? "";
      DocumentSnapshot userDocs =
          await _firebaseFirestore.collection('users').doc(uid).get();
      var allDocs = await _firebaseFirestore.collection('videos').get();
      int allDocsCount = allDocs.docs.length;
      String downloadVideoURI =
          await _uploadVideoToStore("Video $allDocsCount", videoPath);
      String downloadThumbnailURI =
          await _uploadImageToStorage("Video $allDocsCount", videoPath);
      VideoModel model = VideoModel(
          username: (userDocs.data()! as Map<String, dynamic>)["name"],
          uid: uid,
          id: "Video $allDocsCount",
          songName: songName,
          caption: caption,
          videoURL: downloadVideoURI,
          thumbnailURL: downloadThumbnailURI,
          profilePic: (userDocs.data() as Map<String, dynamic>)["profilePics"],
          likes: [],
          commentCount: 0,
          shareCount: 0);
      await _firebaseFirestore
          .collection('videos')
          .doc("Video $allDocsCount")
          .set(model.toJson());

      return model;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _uploadVideoToStore(String videoId, String videoPath) async {
    Reference ref = _firebaseStorage.ref().child('videos').child(videoId);
    UploadTask uplaodTask =
        ref.putFile(await _compressVideo(videoPath) ?? File(""));
    TaskSnapshot snap = await uplaodTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> _uploadImageToStorage(String videoId, String videoPath) async {
    Reference ref = _firebaseStorage.ref().child('thumbnails').child(videoId);
    UploadTask uplaodTask =
        ref.putFile(await _getThumbnail(videoPath) ?? File(""));
    TaskSnapshot snap = await uplaodTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo?.file;
  }
}
