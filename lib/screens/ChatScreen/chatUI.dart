import 'package:flutter/material.dart';
import 'directMessages.dart';
import 'groupMessages.dart';
import 'groupChatUI.dart';

// Placeholder for user data (replace with actual data source)
final String userPhotoUrl = 'https://placehold.it/100'; // Placeholder image URL

class ChatUI extends StatelessWidget {
  final String userName; // Define userName parameter

  ChatUI({required this.userName}); // Include userName in constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // User profile image
            CircleAvatar(
              backgroundImage: NetworkImage(userPhotoUrl),
            ),
            SizedBox(width: 8.0), // Add some spacing between image and name
            // User name
            Text(userName), // Use passed userName
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => {}, // Placeholder for sending message
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
