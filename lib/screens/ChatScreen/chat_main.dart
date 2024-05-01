import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/user_list.dart';
import '../../services/database.dart';

void main() {
  runApp(const ChatPage());
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chat Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Content(),
      ),
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
    selectedIndex = 0;
    _usersStream = DatabaseService().userLists; // Assuming it fetches user data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: selectedIndex == 0
                  ? buildMessagesStream()
                  : buildGroupsContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: const Color(0xFF1E7251),
      height: headerHeight,
      child: Column(
        children: [
          Expanded(child: Container()),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildContent() {
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

  Widget buildMessagesStream() {
    return StreamBuilder<List<UserList>>(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return buildMessagesContent(snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildMessagesContent(List<UserList> users) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: users.length, // This should be the number of users in the list
      itemBuilder: (context, index) {
        final user = users[index]; // Extract the user from the list
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ListTile(
              title: Text(
                '${user.fname} ${user.lname}', // Display user's full name
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: const Text(
                'Most recent chat message',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF1E7251),
                backgroundImage: user.icon != null
                    ? MemoryImage(base64Decode(user.icon))
                    : null,
                child: (user.icon == null || user.icon.isEmpty)
                    ? Text(
                        user.fname[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              onTap: () {}),
        );
      },
    );
  }

  Widget buildGroupsContent() {
    return const Center(
      child: Text('You currently have no groups'),
    );
  }
}
