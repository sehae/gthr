import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gthr/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../models/user_posts.dart';
import '../../shared/loading.dart';
import '../../shared/snackbar.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Content(user: user, userData: userData);
          } else {
            return const Loading();
          }
        });
  }
}

class Content extends StatefulWidget {
  final myUser? user;
  final UserData? userData;

  const Content({Key? key, required this.user, required this.userData})
      : super(key: key);

  @override
  _createContentState createState() => _createContentState();
}

class _createContentState extends State<Content> {
  final TextEditingController _textController = TextEditingController();
  late final FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1E7251)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                String postContent = _textController.text.trim();
                if (postContent.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Color(0xFF1E7251),
                    content: Center(
                      child: Text(
                        'Please enter some text',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ));
                } else {
                  Post newPost = Post(
                    content: postContent,
                    timestamp: DateTime.now(),
                    icon: widget.userData?.icon ?? '',
                    username: widget.userData?.username ?? '',
                  );

                  await DatabaseService(uid: user?.uid).addPost(newPost);

                  showSnackBarFun(context, 'Post created successfully');

                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF1E7251)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Post',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: buildPost(),
      backgroundColor: Colors.white,
    );
  }

  Widget buildPost() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: const Color(0xFF1E7251),
                backgroundImage: widget.userData?.icon != null
                    ? MemoryImage(base64Decode(widget.userData!.icon))
                    : null,
                radius: 25,
                child: (widget.userData?.icon != null &&
                    widget.userData?.icon == '')
                    ? Text(
                  widget.userData?.fname[0].toUpperCase() ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                )
                    : null,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    maxLength: 250,
                    minLines: 1,
                    maxLines: null,
                    controller: _textController,
                    focusNode: _textFocusNode,
                    decoration: const InputDecoration(
                      hintText: "What's poppin'?",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
