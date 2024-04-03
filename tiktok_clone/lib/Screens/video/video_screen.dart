import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/colors.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      if (context.mounted) {
        Navigator.of(context).pushNamed('/conform', arguments: {
          'videoFile': File(video.path),
          'videoPath': video.path,
        });
      }
    }
  }

  void picAction(bool isCamera, bool isVideo, isCancel, BuildContext context) {
    if (isVideo) {
      pickVideo(ImageSource.gallery, context);
    } else if (isCamera) {
      pickVideo(ImageSource.camera, context);
    } else if (isCancel) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  showVideoDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  picAction(false, true, false, context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Gallery", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  picAction(true, false, false, context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Camera", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  picAction(false, false, true, context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.cancel),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Cancel", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showVideoDialog(context);
          },
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              "Add Video",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
