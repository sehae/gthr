import 'package:flutter/material.dart';

class GroupChatUI extends StatelessWidget {
  final String groupName;
  final List<String> members;
  final String groupPhotoUrl; // Placeholder for group photo URL

  const GroupChatUI(
      {super.key, required this.groupName,
      required this.members,
      required this.groupPhotoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Group photo
            CircleAvatar(
              backgroundImage:
                  NetworkImage(groupPhotoUrl), // Use group photo URL
            ),
            const SizedBox(width: 8.0), // Add some spacing between image and name
            // Group name
            Text(groupName),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat message list (placeholder for now)
          Expanded(
            child: ListView.builder(
              // Placeholder for displaying chat messages
              itemBuilder: (context, index) => ListTile(
                title:
                    Text('Message $index'), // Replace with actual message data
              ),
              itemCount: 10, // Placeholder for number of messages
            ),
          ),
          // Chat input field (placeholder for now)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => {}, // Placeholder for sending message
                ),
              ],
            ),
          ),
        ],
      ),
      // Add a floating action button to show group members
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog or bottom sheet to display group members (placeholder)
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content vertically
                children: [
                  const Text(
                    'Group Members',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0), // Add some spacing
                  ListView.builder(
                    // Display group members in a list
                    shrinkWrap: true, // Prevent list from expanding
                    itemCount: members.length,
                    itemBuilder: (context, index) => Text(members[index]),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.group),
      ),
    );
  }
}
