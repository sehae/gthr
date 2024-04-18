import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;
  bool _showNotifications = true;
  bool _newEvents = true;
  bool _orgAnnouncements = true;
  bool _recommendations = true;
  bool _friendRequests = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
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
              _buildOptionTile('Your Preferences', Icons.arrow_forward_ios),
              // Notifications Category
              _buildCategoryHeader('Notifications'),
              _buildToggleOptionTile('Show Notifications', _showNotifications),
              _buildToggleOptionTile('New Events', _newEvents),
              _buildToggleOptionTile('Org. Announcements', _orgAnnouncements),
              _buildToggleOptionTile('Recommendations', _recommendations),
              _buildToggleOptionTile('Friend Requests', _friendRequests),
              // Display Category
              _buildCategoryHeader('Display'),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
              // Delete Account Button
              _buildDeleteAccountButton(),
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
        style: TextStyle(
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
        // Handle tap on the option tile
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
          }
        });
      },
    );
  }

  Widget _buildDeleteAccountButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: _deleteAccount,
        child: Text('Delete Account'),
      ),
    );
  }

  void _deleteAccount() {
    // Implement the logic to delete the account
    // This function will be called when the "Delete Account" button is pressed
  }
}
