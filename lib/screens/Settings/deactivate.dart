import 'package:flutter/material.dart';

class DeactivatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Deactivate your account'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/user_profile_pic.jpg'), // Placeholder for user's avatar
              radius: 30,
            ),
            SizedBox(height: 16),
            Text(
              'Rohan :3',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              '@username',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'This will deactivate your account',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Text(
                'You’re about to start the process of deactivating your GTHR account. Your display name, @username, and public profile will no longer be viewable on the application.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'What else you should know',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600), // Constrain text to a maximum width
              child: Text(
                'You can restore your GTHR account if it was accidentally or wrongfully deactivated for up to 30 days after deactivation.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Ensure the button stretches to fill the width
              child: ElevatedButton(
                onPressed: () {
                  // Deactivation logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Deactivate'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
