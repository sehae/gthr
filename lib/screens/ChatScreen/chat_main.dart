import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';
import '../../models/user.dart';
import '../../models/user_list.dart';
import '../../models/chat_message.dart';
import 'chat_page.dart';
import 'group_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Content());
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late Stream<List<UserList>> _usersStream;
  late Stream<List<GroupChat>> _groupStream;
  final double headerHeight = 180;
  int selectedIndex = 0;
  myUser? currentUser;

  _ContentState() {
    _usersStream = DatabaseService().userLists;
    _groupStream = DatabaseService().getAllGroupChats();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<myUser?>(context);

    if (currentUser == null) {
      return const Center(child: Text('No current user found'));
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: currentUser?.uid).userData,
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

          return Scaffold(
              floatingActionButton: selectedIndex == 1
                  ? FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => CreateGroupChatDialog(),
                        );
                      },
                      child: const Icon(Icons.group_add),
                      backgroundColor: const Color(0xFF1E7251),
                    )
                  : null,
              body: Column(
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
              ));
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
          final users = snapshot.data ?? [];

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
      return const Center(child: Text('No users available'));
    }

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
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          title: Text('${user.fname} ${user.lname}'),
          subtitle: const Text('Last message preview'),
          onTap: () {
            final senderId = currentUser?.uid;
            final receiverId = user.uid;

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  user: user,
                  currentUserId: senderId ?? "",
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildGroupsContent() {
    return StreamBuilder<List<GroupChat>>(
      stream: _groupStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final groupChats = snapshot.data ?? [];

          if (groupChats.isEmpty) {
            return const Center(child: Text("No group chats available"));
          }

          return ListView.builder(
            itemCount: groupChats.length,
            itemBuilder: (context, index) {
              final groupChat = groupChats[index];

              return ListTile(
                leading: const Icon(Icons.group, color: Color(0xFF1E7251)),
                title: Text(
                  groupChat.groupName ?? "Unnamed Group",
                ),
                subtitle: Text("Members: ${groupChat.members.length}"),
                onTap: () {
                  final senderId = currentUser?.uid ?? ''; // Ensure not null

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GroupPage(
                        groupId: groupChat.groupId,
                        groupName: groupChat.groupName,
                        currentUserId: senderId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}

class CreateGroupChatDialog extends StatefulWidget {
  const CreateGroupChatDialog({super.key});

  @override
  _CreateGroupChatDialogState createState() => _CreateGroupChatDialogState();
}

class _CreateGroupChatDialogState extends State<CreateGroupChatDialog> {
  final TextEditingController _groupNameController = TextEditingController();
  final List<UserList> _selectedMembers = [];

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Group Chat"),
      content: SizedBox(
        width: double.maxFinite, // Ensures the content expands to full width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                hintText: "Enter group name",
              ),
            ),
            const SizedBox(height: 10),
            Text("Select Members"),
            Expanded(
              child: StreamBuilder<List<UserList>>(
                stream: DatabaseService().userLists,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error loading users: ${snapshot.error}"),
                    );
                  }

                  final users = snapshot.data ?? [];

                  if (users.isEmpty) {
                    return const Text("No users found");
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final isSelected = _selectedMembers.contains(user);

                      return CheckboxListTile(
                        title: Text('${user.fname} ${user.lname}'),
                        value: isSelected, // Ensure non-null value
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedMembers
                                  .add(user); // Update list when checked
                            } else {
                              _selectedMembers
                                  .remove(user); // Update when unchecked
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cancel
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            final groupName = _groupNameController.text.trim();
            final memberDetails = _selectedMembers.map((user) {
              return {
                'uid': user.uid,
                'fname': user.fname,
                'lname': user.lname,
              };
            }).toList(); // Ensure list contains user details

            if (groupName.isNotEmpty && memberDetails.isNotEmpty) {
              await DatabaseService().createGroupChat(groupName, memberDetails);
              Navigator.of(context).pop(); // Close the dialog after success
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Group name and members cannot be empty")),
              ); // Provide feedback for invalid input
            }
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}
