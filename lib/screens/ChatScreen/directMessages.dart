import 'package:flutter/material.dart';
import 'chatUI.dart';

class DirectMessagesScreen extends StatelessWidget {
  // Placeholder user names (replace with actual data source)
  final List<String> userNames = [
    'John Doe',
    'Jane Doe',
    'Alice Smith',
    'Bob Johnson',
    'Emily Jones'
  ];

  DirectMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
      ),
      body: ListView.builder(
        itemCount: userNames.length, // Use userNames list length
        itemBuilder: (context, index) {
          return ListTile(
            // Wrap ListTile with GestureDetector for click handling
            onTap: () {
              // Pass user name as an argument to ChatUI
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatUI(userName: userNames[index])),
              );
            },
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person),
                ),
                // Online status indicator (green for all now)
                Positioned(
                  bottom: 2.0,
                  right: 2.0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Set to green for all users
                    ),
                  ),
                ),
              ],
            ),
            title: Text(userNames[index]), // Use user names from list
            subtitle: const Text('This is a message preview'),
            trailing: Text(
              '10:00 PM',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[600],
              ),
            ),
          );
        },
      ),
    );
  }
}
