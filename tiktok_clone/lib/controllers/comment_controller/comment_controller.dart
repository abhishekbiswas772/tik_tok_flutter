import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';
import 'package:tiktok_clone/model/commentModel.dart';

class CommentController {
  final AuthController _authController = AuthController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String postId = "";

  void updatePostID(String pId) {
    postId = pId;
  }

  Stream<List<CommentModel>> getAllVideos() {
    return _firebaseFirestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot snap) {
      return snap.docs.map((DocumentSnapshot doc) {
        return CommentModel.fromSnap(doc);
      }).toList();
    });
  }

  Future<bool> postComments(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot snap = await _firebaseFirestore
            .collection('users')
            .doc(_authController.user?.uid)
            .get();
        var allDocs = await _firebaseFirestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .get();

        int len = allDocs.docs.length;
        String userName = (snap.data()! as dynamic)['name'];
        String profilePic = (snap.data()! as dynamic)['profilePics'];
        CommentModel commentModel = CommentModel(
            username: userName,
            comment: commentText.trim(),
            datePublished: DateTime.now(),
            likes: [],
            profilePhoto: profilePic,
            uid: (snap.data()! as dynamic)['uid'],
            id: "Comment $len");
        await _firebaseFirestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .doc('Comment $len')
            .set(commentModel.toJson());
        DocumentSnapshot snapVideo =
            await _firebaseFirestore.collection('videos').doc(postId).get();
        await _firebaseFirestore.collection('videos').doc(postId).update({
          'commentCount': (snapVideo.data() as dynamic)['commentCount'] + 1,
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  likeComment(String id) async {
    String uid = _authController.user?.uid ?? "";
    DocumentSnapshot snap = await _firebaseFirestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .doc(id)
        .get();
    var likeData = (snap.data() as dynamic)['likes'];
    if (likeData != null) {
      if (likeData.contains(uid)) {
        await _firebaseFirestore.collection('videos').doc(postId).collection('comments').doc(id).update({
          'likes' : FieldValue.arrayRemove([uid]),
        });
      }else {
        await _firebaseFirestore.collection('videos').doc(postId).collection('comments').doc(id).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    }
  }
}