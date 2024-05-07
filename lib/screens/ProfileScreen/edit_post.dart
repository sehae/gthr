import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gthr/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../models/user_posts.dart';
import '../../shared/loading.dart';
import '../../shared/snackbar.dart';

class EditPostScreen extends StatelessWidget {
  final String postId;
  final String initialContent;

  const EditPostScreen({Key? key, required this.postId, required this.initialContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Content(user: user, userData: userData, postId: postId, initialContent: initialContent);
          } else {
            return const Loading();
          }
        });
  }
}


class Content extends StatefulWidget {
  final myUser? user;
  final UserData? userData;
  final String postId;
  final String initialContent;

  const Content({
    Key? key,
    required this.user,
    required this.userData,
    required this.postId,
    required this.initialContent,
  })
      : super(key: key);

  @override
  _createContentState createState() => _createContentState();
}

class _createContentState extends State<Content> {
  final TextEditingController _textController = TextEditingController();
  late final FocusNode _textFocusNode;
  final _formKey = GlobalKey<FormState>();
  String _content = '';

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _content = widget.initialContent;
    _textController.text = _content;
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
                if (widget.user != null) {
                  Post newPost = Post(
                    content: _textController.text,
                    timestamp: DateTime.now(),
                    icon: widget.userData?.icon ?? '',
                    username: widget.userData?.username ?? '',
                  );

                  await DatabaseService(uid: widget.user!.uid).updatePost(widget.postId, _content);
                  showSnackBarFun(context, 'Your post has been updated!');

                  Navigator.pop(context);
                } else {
                  print('User is null, cannot update post');
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1E7251)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Update', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: buildPost(),
      backgroundColor: Colors.white,
    );
  }

  Widget buildPost(){
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
                    onChanged: (value) {
                      setState(() {
                        _content = value;
                      });
                    },
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