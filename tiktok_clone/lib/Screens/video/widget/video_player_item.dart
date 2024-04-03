import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoPlayerItem extends StatefulWidget {
  final String videoURL;
  const VideoPlayerItem({Key? key, required this.videoURL}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    final videoFile = await prepareForFile(widget.videoURL);
    _videoController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          isLoading = true;
        }); // Update the widget once the video is initialized
        _videoController.play();
        _videoController.setVolume(1);
        _videoController.setLooping(true);
      });
  }

  Future<File> prepareForFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final appDir = await getTemporaryDirectory();
    final file = File('${appDir.path}/video.mp4');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                )
              : const CircularProgressIndicator(), // Show a loading indicator until the video is initialized
        ),
      ),
    );
  }
}
