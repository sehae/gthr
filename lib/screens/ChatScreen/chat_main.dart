import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';
import '../../models/user.dart';
import '../../models/user_list.dart';
import 'chat_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Content(),
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late Stream<List<UserList>> _usersStream;
  final double headerHeight = 180;
  int selectedIndex = 0;

  _ContentState() {
    _usersStream = DatabaseService().userLists;
  }

  @override
  Widget build(BuildContext context) {
    final myUser? currentUser = Provider.of<myUser?>(context);

    if (currentUser == null) {
      return const Center(child: Text('No current user found'));
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: currentUser.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final currentUserData = snapshot.data;

          if (currentUserData == null) {
            return const Center(child: Text('No current user data found'));
          }

          return Column(
            children: [
              buildHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: selectedIndex == 0
                      ? buildMessagesStream(currentUserData.fname)
                      : buildGroupsContent(),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildHeader() {
    return Container(
      color: const Color(0xFF1E7251),
      height: headerHeight,
      child: Column(
        children: [
          const Spacer(),
          buildContentHeader(),
        ],
      ),
    );
  }

  Widget buildContentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildContentButton('Messages', 0),
        buildContentButton('Groups', 1),
      ],
    );
  }

  Widget buildContentButton(String text, int index) {
    final isActive = selectedIndex == index;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? const Color(0xFFFFDD0A) : Colors.transparent,
                width: 5,
              ),
            ),
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) =>
                    isActive ? Colors.white : Colors.white.withOpacity(0.8),
              ),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMessagesStream(String currentUserFname) {
    return StreamBuilder<List<UserList>>(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final users = snapshot.data!;

          // Exclude users with same fname as current user
          final filteredUsers = users
              .where(
                (user) => user.fname != currentUserFname,
              )
              .toList();

          return buildMessagesContent(filteredUsers);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildMessagesContent(List<UserList> users) {
    if (users.isEmpty) {
      return const Center(child: Text('Loading Users...'));
    }

    final myUser? currentUser = Provider.of<myUser?>(context);

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF1E7251),
            backgroundImage: user.icon.isNotEmpty
                ? MemoryImage(base64Decode(user.icon))
                : null,
            child: user.icon.isEmpty
                ? Text(
                    user.fname[0].toUpperCase(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )
                : null,
          ),
          title: Text('${user.fname} ${user.lname}'),
          subtitle: const Text('Last message preview'),
          onTap: () {
            if (currentUser != null) {
              // Ensure currentUser exists
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    chatPartner: user, // Chat partner
                    currentUser: currentUser, // Pass the current user
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget buildGroupsContent() {
    return const Center(child: Text('No groups available'));
  }
}
