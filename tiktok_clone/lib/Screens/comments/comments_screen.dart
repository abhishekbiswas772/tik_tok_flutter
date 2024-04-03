import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/comment_controller/comment_controller.dart';
import 'package:tiktok_clone/model/commentModel.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatefulWidget {
  final String id;
  const CommentsScreen({super.key, required this.id});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final CommentController _commentSendGetController = CommentController();
  final AuthController _authController = AuthController();
  Stream<List<CommentModel>>? _commentModel;

  @override
  void initState() {
    super.initState();
    _commentModel = _commentSendGetController.getAllVideos();
  }

  void postCommentsToFirebase(String comment, BuildContext context) async {
    bool resultFromFirebase =
        await _commentSendGetController.postComments(comment);
    if (!resultFromFirebase) {
      if (context.mounted) {
        var snackBar =
            const SnackBar(content: Text('Signin failed!, Please try again'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
          stream: _commentModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _commentSendGetController.updatePostID(widget.id);
              List<CommentModel> commentModel = snapshot.data ?? [];
              return SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: commentModel.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  backgroundImage: NetworkImage(
                                      commentModel[index].profilePhoto),
                                ),
                                title: Row(
                                  children: [
                                    Text("${commentModel[index].username} ",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700)),
                                    Text(commentModel[index].comment,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      timeago.format(commentModel[index]
                                          .datePublished
                                          .toDate()),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      commentModel[index]
                                          .likes
                                          .length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    _commentSendGetController
                                        .likeComment(commentModel[index].id);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    size: 25,
                                    color: (commentModel[index].likes.contains(
                                            _authController.user?.uid))
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              );
                            }),
                      ),
                      const Divider(),
                      ListTile(
                        title: TextFormField(
                          controller: _commentController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            labelText: "Comments",
                            labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            postCommentsToFirebase(
                                _commentController.text, context);
                          },
                          child: const Text(
                            "send",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
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
