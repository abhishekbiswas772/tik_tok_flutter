import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok_clone/Screens/video/widget/circular_animation.dart';
import 'package:tiktok_clone/Screens/video/widget/video_player_item.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/video_upload_controller/video_show_controller.dart';
import 'package:tiktok_clone/model/video_model.dart';
import 'package:http/http.dart' as http;

class VideoShowScreen extends StatefulWidget {
  const VideoShowScreen({super.key});

  @override
  State<VideoShowScreen> createState() => _VideoShowScreenState();
}

class _VideoShowScreenState extends State<VideoShowScreen> {
  final VideoShowController _videoShowController = VideoShowController();
  final AuthController _authController = AuthController();
  Stream<List<VideoModel>>? _modelList;

  @override
  void initState() {
    super.initState();
    _modelList = _videoShowController.getAllVideos();
  }

  Future<File> profileImage(String networkImage) async {
    try {
      final response = await http.get(Uri.parse(networkImage));
      final appDir = await getTemporaryDirectory();
      final file = File('${appDir.path}/image.jpg');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      print(e);
      return File("");
    }
  }

  Widget _buildProfilePic(String profilePath) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: profilePath,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(11),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(colors: [Colors.grey, Colors.white]),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _modelList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<VideoModel> videos = snapshot.data ?? [];
              return PageView.builder(
                  itemCount: videos.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        VideoPlayerItem(videoURL: videos[index].videoURL),
                        Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Expanded(
                                child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(videos[index].username,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(videos[index].caption,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.music_note,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                Text(videos[index].songName,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            )
                                          ],
                                        ))),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildProfilePic(
                                          videos[index].profilePic),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _videoShowController
                                                  .likeVideo(videos[index].id);
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: (videos[index]
                                                      .likes
                                                      .contains(_authController
                                                              .user?.uid ??
                                                          0))
                                                  ? Colors.red
                                                  : Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                              videos[index]
                                                  .likes
                                                  .length
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  '/comment',
                                                  arguments: {
                                                    'id': videos[index].id,
                                                  });
                                            },
                                            child: const Icon(
                                              Icons.comment,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                              videos[index]
                                                  .commentCount
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.reply,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                              videos[index]
                                                  .shareCount
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      // CirCularAnimation(
                                      //     widget: _buildMusicAlbum(
                                      //         videos[index].profilePic))
                                    ],
                                  ),
                                ),
                              ],
                            ))
                          ],
                        )
                      ],
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
