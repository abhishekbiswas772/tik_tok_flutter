import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok_clone/Screens/custom/input_widget.dart';
import 'package:tiktok_clone/controllers/video_upload_controller/upload_video_controller.dart';
import 'package:tiktok_clone/model/video_model.dart';
import 'package:video_player/video_player.dart';

class ConformScreen extends StatefulWidget {
  final File videoFile;
  final String videPath;
  const ConformScreen(
      {super.key, required this.videoFile, required this.videPath});

  @override
  State<ConformScreen> createState() => _ConformScreenState();
}

class _ConformScreenState extends State<ConformScreen> {
  VideoPlayerController? controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final VideoUploadController _videoUploadController = VideoUploadController();

  void _uploadAndShareVideo(BuildContext context) async {
    VideoModel? result = await _videoUploadController.uploadVideo(
        _songController.text, _captionController.text, widget.videPath);
    if (result != null) {
      if (context.mounted) {
        var snackBar =
            const SnackBar(content: Text('Video Uploaded Successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop();
      }
    } else {
      if (context.mounted) {
        var snackBar = const SnackBar(content: Text('Video Upload Failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller?.initialize();
    controller?.play();
    controller?.setVolume(1.0);
    controller?.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              FittedBox(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width + 150,
                  child: AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: VideoPlayer(controller!)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width - 20,
                        child: CustomTxtFieldWidget(
                          controller: _songController,
                          labelText: "Songs",
                          iconData: Icons.music_note,
                          isObscure: false,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width - 20,
                          child: CustomTxtFieldWidget(
                            controller: _captionController,
                            labelText: "Caption",
                            iconData: Icons.closed_caption,
                            isObscure: false,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _uploadAndShareVideo(context);
                          },
                          child: const Text("Shared!",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
