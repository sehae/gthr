import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:gthr/screens/ProfileScreen/profile_edit.dart';
import 'package:gthr/services/database.dart';
import 'package:gthr/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:gthr/screens/ProfileScreen/create_post.dart';

import '../../../../../models/user.dart';
import '../../models/user_posts.dart';
import 'edit_post.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Content(user: user, userData: userData);
            print('data received');
          } else {
            print('not received');
            return Loading();
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
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final double coverHeight = 150;
  final double profileHeight = 144;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildTop(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildProfileInfo(),
                  buildContent(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const CreatePostScreen(),
                ),
            barrierDismissible: true,
            barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black45,
            transitionDuration: const Duration(milliseconds: 250),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        shape: CircleBorder(),
        backgroundColor: Color(0xff1E7251),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    final buttonPOS = coverHeight + 10;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          left: 20,
          child: buildProfileImage(),
        ),
        Positioned(
          top: buttonPOS,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: profileEdit(),
                    ),
                barrierDismissible: true,
                barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 250),
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Colors.white;
                },
              ),
              side: MaterialStateProperty.resolveWith<BorderSide>(
                    (Set<MaterialState> states) {
                  return const BorderSide(
                    color: Color(0xFF1E7251),
                    width: 2.0,
                  );
                },
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Color(0xFF2C2C30),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    child: (widget.userData?.header != null &&
        widget.userData!.header.isNotEmpty)
        ? Image.memory(
      base64Decode(widget.userData!.header),
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    )
        : Container(
      width: double.infinity,
      height: coverHeight,
      color: Color(0xFF1E7251),
    ),
  );

  Widget buildProfileImage() => Container(
    padding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Color(0xFF1E7251),
      backgroundImage: widget.userData?.icon != null
          ? MemoryImage(base64Decode(widget.userData!.icon))
          : null,
      child: (widget.userData?.icon != null && widget.userData?.icon == '')
          ? Text(
        widget.userData?.fname[0].toUpperCase() ?? '',
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.white,
        ),
      )
          : null,
    ),
  );

  Widget buildProfileInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 8,
      ),
      Text(
        '${widget.userData!.fname} ${widget.userData!.lname}',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        '@${widget.userData?.username}',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      Text(
        widget.userData!.bio,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      Row(
        children: [
          Icon(
            Icons.location_on,
            size: 20,
            color: Color(0xFF2C2C30),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            widget.userData!.location,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      Row(
        children: [
          TextButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return Colors.transparent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFF4E4C4C).withOpacity(0.5);
                    }
                    return const Color(0xFF4E4C4C);
                  },
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    '69',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Friends',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return Colors.transparent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFF4E4C4C).withOpacity(0.5);
                    }
                    return const Color(0xFF4E4C4C);
                  },
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    '420',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
        ],
      ),
    ],
  );

  Widget buildContent() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContentButton('Posts', 0),
                buildContentButton('Replies', 1),
                buildContentButton("GTHR'D", 2),
                buildContentButton('Likes', 3),
              ],
            ),
          ),
          if (selectedIndex == 0) buildPostsContent(),
          if (selectedIndex == 1) buildRepliesContent(),
          if (selectedIndex == 2) buildGthrContent(),
          if (selectedIndex == 3) buildLikesContent(),
        ],
      ),
    );
  }

  Widget buildContentButton(String text, int index) {
    final isActive = selectedIndex == index;

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: isActive ? const Color(0xFFFF4E1A) : Colors.transparent,
                width: 5.0,
              ))),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color(0xFF4E4C4C).withOpacity(0.5);
              }
              return isActive ? const Color(0xFF4E4C4C) : Colors.black;
            },
          ),
        ),
        child: Text(text,
            style: const TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }

  Widget buildPostsContent() {
    return StreamBuilder<List<Post>>(
      stream: DatabaseService(uid: widget.user?.uid).posts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = snapshot.data!;
          posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          if (posts.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text('Nothing to see here, fam. Why not post something?')
                ],
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF1E7251),
                            backgroundImage: widget.userData?.icon != null
                                ? MemoryImage(base64Decode(widget.userData!.icon))
                                : null,
                            child: (widget.userData?.icon != null &&
                                widget.userData?.icon == '')
                                ? Text(
                              widget.userData?.fname[0].toUpperCase() ?? '',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            )
                                : null,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '@${widget.userData!.username} · ${timeago.format(posts[index].timestamp, locale: 'en_short')}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  PopupMenuButton<int>(
                                    icon: const Icon(Icons.more_horiz),
                                    color: Colors.grey[100],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    elevation: 2.0,
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Delete Post',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            FaIcon(FontAwesomeIcons.trashCan, color: Colors.red,),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Edit Post'),
                                            FaIcon(FontAwesomeIcons.pen),
                                          ],
                                        ),
                                      )
                                    ],
                                    onSelected: (value) {
                                      if (value == 1) {
                                        String? postId = posts[index].postId;
                                        if (postId != null) {
                                          confirmDeletePost(postId);
                                        } else {
                                          print('Post ID is null');
                                        }
                                      } else if (value == 2) {
                                        showGeneralDialog(
                                          context: context,
                                          pageBuilder: (BuildContext context, Animation<double> animation,
                                              Animation<double> secondaryAnimation) =>
                                              EditPostScreen(
                                                postId: posts[index].postId!,
                                                initialContent: posts[index].content,
                                              ),
                                          barrierDismissible: true,
                                          barrierLabel:
                                          MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                          barrierColor: Colors.black45,
                                          transitionDuration: const Duration(milliseconds: 250),
                                          transitionBuilder:
                                              (context, animation, secondaryAnimation, child) {
                                            return SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(0, 1),
                                                end: Offset.zero,
                                              ).animate(animation),
                                              child: child,
                                            );
                                          },
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                              Text(
                                posts[index].content,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void confirmDeletePost(String? postId) {
    if (postId != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this post?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  DatabaseService(uid: widget.user?.uid).deletePost(postId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Post ID is null');
    }
  }

  Widget buildRepliesContent() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Text('Nothing to see here, fam. Why not reply to someone?')
      ],
    ),
  );

  Widget buildGthrContent() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Image.network(
            'https://asset-ent.abs-cbn.com/ent/entertainment/media/onemusic/lovebox.jpg?ext=.jpg'),
        Image.network(
            'https://scontent.fmnl8-1.fna.fbcdn.net/v/t39.30808-6/401836757_737590591748457_5740288807220724461_n.jpg?stp=dst-jpg_p843x403&_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_ohc=zW3lI9lyNNkAb7qpwLC&_nc_ht=scontent.fmnl8-1.fna&cb_e2o_trans=q&oh=00_AfARb92ZkIqxiMZf_HvGqwaLlD0l7sqe-SUmUguq4gSjNQ&oe=66259EC4'),
      ],
    ),
  );

  Widget buildLikesContent() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [Text('Nothing to see here, fam. Why not like something?')],
    ),
  );
}