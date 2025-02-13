import 'package:flutter/material.dart';
import 'account_info.dart';
import 'change_pw.dart';
import 'deactivate.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showNotifications = true;
  bool _newEvents = true;
  bool _orgAnnouncements = true;
  bool _recommendations = true;
  bool _friendRequests = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Account Category
              _buildCategoryHeader('Account'),
              _buildOptionTile('Account Details', Icons.arrow_forward_ios),
              _buildOptionTile('Change Password', Icons.arrow_forward_ios),
              // Notifications Category
              _buildCategoryHeader('Notifications'),
              _buildToggleOptionTile('Show Notifications', _showNotifications),
              _buildToggleOptionTile('New Events', _newEvents),
              _buildToggleOptionTile('Org. Announcements', _orgAnnouncements),
              _buildToggleOptionTile('Recommendations', _recommendations),
              _buildToggleOptionTile('Friend Requests', _friendRequests),
              // Display Category
              _buildCategoryHeader('Display'),
              _buildToggleOptionTile('Dark Mode', _darkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOptionTile(String title, IconData icon) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: () {
        if (title == 'Account Details') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfo()));
        }
        if (title == 'Change Password'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
        }
      },
    );
  }


  Widget _buildToggleOptionTile(String title, bool value) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) {
        setState(() {
          switch (title) {
            case 'Show Notifications':
              _showNotifications = newValue;
              break;
            case 'New Events':
              _newEvents = newValue;
              break;
            case 'Org. Announcements':
              _orgAnnouncements = newValue;
              break;
            case 'Recommendations':
              _recommendations = newValue;
              break;
            case 'Friend Requests':
              _friendRequests = newValue;
              break;
            case 'Dark Mode':
              _darkMode = newValue;
              break;
          }
        });
      },
      activeColor: const Color(0xff1E7251), // Color when toggle is enabled
      inactiveThumbColor: const Color(0xff1E7251).withOpacity(0.3), // Color when toggle is disabled
      inactiveTrackColor: const Color(0xff1E7251).withOpacity(0.3), // Color of the toggle track when toggle is disabled
    );
  }
}