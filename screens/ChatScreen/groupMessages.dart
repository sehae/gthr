import 'package:flutter/material.dart';
import 'directMessages.dart';
import 'chatUI.dart';
import 'groupChatUI.dart';

// Placeholder group names and member lists (replace with actual data)
final List<String> groupNames = ['Group A', 'Group B', 'Group C'];
final List<List<String>> groupMembers = [
  ['John Doe', 'Jane Doe', 'Alice Smith'],
  ['Bob Johnson', 'Emily Jones', 'Michael Brown'],
  ['David Lee', 'Sarah Miller', 'William Smith'],
];

class GroupMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Messages'),
      ),
      body: ListView.builder(
        itemCount: groupNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            // Wrap ListTile with GestureDetector for click handling
            onTap: () {
              // Pass group name, member list, and a placeholder group photo URL (replace)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupChatUI(
                    groupName: groupNames[index],
                    members: groupMembers[index],
                    groupPhotoUrl:
                        'https://placehold.it/100', // Placeholder URL (replace)
                  ),
                ),
              );
            },
            leading: Stack(
              children: [
                CircleAvatar(
                  // Placeholder for group image (replace with actual image loading)
                  child: Icon(Icons.group),
                  backgroundColor: Colors.grey[200],
                ),
                // Online status indicator (green for all now)
                Positioned(
                  bottom: 2.0,
                  right: 2.0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Set to green for all groups
                    ),
                  ),
                ),
              ],
            ),
            title: Text(groupNames[index]),
            subtitle: Text('This is a message preview'),
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
