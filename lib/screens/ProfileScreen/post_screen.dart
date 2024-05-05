import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../models/user_posts.dart';
import '../../services/database.dart';
import '../../shared/custom_scrollbar.dart';
import '../../shared/loading.dart';

class PostScreen extends StatelessWidget {
  final Post post;

  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Content(user: user, userData: userData, post: post);
          } else {
            return const Loading();
          }
        });
  }
}

class Content extends StatefulWidget {
  final myUser? user;
  final UserData? userData;
  final Post post;

  const Content(
      {Key? key,
      required this.user,
      required this.userData,
      required this.post})
      : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomSheet: chatBar(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left),
          ),
          title: const Text(
            'Post',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: CustomScrollbar(
                  child: Column(
                    children: <Widget>[
                      buildUser(),
                      buildPostContent(),
                      buildReplies(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget chatBar() {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Post your reply",
                border: OutlineInputBorder(),
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, TextEditingValue value, _) {
              if (value.text.isNotEmpty) {
                return IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle sending message
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildUser() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: widget.userData?.icon != null
            ? MemoryImage(base64Decode(widget.userData!.icon))
            : null,
        radius: 25,
        child: (widget.userData?.icon != null && widget.userData?.icon == '')
            ? Text(
                widget.userData?.fname[0].toUpperCase() ?? '',
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      title: Text('${widget.userData?.fname} ${widget.userData!.lname}'),
      subtitle: Text('@${widget.userData?.username}'),
    );
  }

  Widget buildPostContent() {
    return ListTile(
      title: Text(widget.post.content),
      subtitle:
          Text(DateFormat('h:mm a . M/d/yy').format(widget.post.timestamp)),
    );
  }

  Widget buildReplies() {
    return const ListTile(
      title: Text('Replies'),
    );
  }
}
