import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';
import 'package:tiktok_clone/model/video_model.dart';

class VideoShowController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthController _authController = AuthController();

  Stream<List<VideoModel>> getAllVideos() {
    return _firebaseFirestore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot snap) {
      return snap.docs.map((DocumentSnapshot doc) {
        return VideoModel.fromSnap(doc);
      }).toList();
    });
  }

  likeVideo(String idVideo) async {
    DocumentSnapshot snap =
        await _firebaseFirestore.collection('videos').doc(idVideo).get();

    final data = (snap.data() as dynamic);
    var uid = _authController.user?.uid;
    if (data != null) {
      if (data['likes'].contains(uid)) {
        await _firebaseFirestore.collection('videos').doc(idVideo).update({
          'likes' : FieldValue.arrayRemove([uid]),
        });
      }else {
        await _firebaseFirestore.collection('videos').doc(idVideo).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    }
  }
}
