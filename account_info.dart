import 'package:flutter/material.dart';
import 'change_un.dart';
import 'deactivate.dart';

class AccountInfo extends StatelessWidget {
  final String currentUsername = '@aqcplod'; // Static username for demonstration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Username'),
            subtitle: Text(currentUsername),
            onTap: () {
              // Navigate to the ChangeUsernamePage when username is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeUsernamePage(currentUsername: currentUsername),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Email Address', style: TextStyle(color: Colors.grey)),
            subtitle: Text('display email here', style: TextStyle(color: Colors.grey)), // Example email address
          ),
          ListTile(
            title: Text('Deactivate Account', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.push(
                context, // This context is necessary for navigation
                MaterialPageRoute(
                  builder: (context) => DeactivatePage(), // Assuming DeactivatePage is correctly defined in 'deactivate.dart'
                ),
              );
              // Auth service here
            },
          ),
        ],
      ),
    );
  }
}
