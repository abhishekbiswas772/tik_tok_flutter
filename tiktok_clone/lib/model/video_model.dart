import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String id;
  String songName;
  String caption;
  String videoURL;
  String thumbnailURL;
  String profilePic;
  List likes;
  int commentCount;
  int shareCount;

  VideoModel(
      {required this.username,
      required this.uid,
      required this.id,
      required this.songName,
      required this.caption,
      required this.videoURL,
      required this.thumbnailURL,
      required this.profilePic,
      required this.likes,
      required this.commentCount,
      required this.shareCount});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "songName": songName,
        "caption": caption,
        "videoURL": videoURL,
        "thumbnailURL": thumbnailURL,
        "profilePic": profilePic,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount
      };

  static VideoModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VideoModel(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        songName: snapshot['songName'],
        caption: snapshot['caption'],
        videoURL: snapshot['videoURL'],
        thumbnailURL: snapshot['thumbnailURL'],
        profilePic: snapshot['profilePic'],
        likes: snapshot['likes'],
        commentCount: snapshot['commentCount'],
        shareCount: snapshot['shareCount']);
  }
}
