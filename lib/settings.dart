import 'package:better_gthr/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SettingsPage(),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Color(0xff1E7251),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: FaIcon(FontAwesomeIcons.bars), // Replace with Font Awesome bars icon
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: null,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: Container(
            color: Color(0xFFC7CCCA),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Center(
                          child: Image.asset('assets/gthr_logo2.png'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.event,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Events',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.chat_bubble,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Chats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.people_alt_rounded,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xFF1E5720),
                    size: 32,
                  ),
                  title: Text(
                    'Sign-out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
              _buildToggleOptionTile('Dark Mode', _darkMode),
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
          case 'Dark Mode':
            _darkMode = newValue;
            break;
        }
      });
    },
    activeColor: Color(0xff1E7251), // Color when toggle is enabled
    inactiveThumbColor: Color(0xff1E7251).withOpacity(0.3), // Color when toggle is disabled
    inactiveTrackColor: Color(0xff1E7251).withOpacity(0.3), // Color of the toggle track when toggle is disabled
  );
}


Widget _buildDeleteAccountButton() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 20),
    child: ElevatedButton(
      onPressed: _deleteAccount,
      child: Text(
        'Delete Account',
        style: TextStyle(color: Colors.red), // Set text color to red
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade50), // Yellow background color
      ),
    ),
  );
}

  void _deleteAccount() {
    // Implement the logic to delete the account
    // This function will be called when the "Delete Account" button is pressed
  }
}import 'package:better_gthr/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SettingsPage(),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Color(0xff1E7251),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: FaIcon(FontAwesomeIcons.bars), // Replace with Font Awesome bars icon
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: null,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: Container(
            color: Color(0xFFC7CCCA),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Center(
                          child: Image.asset('assets/gthr_logo2.png'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.event,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Events',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.chat_bubble,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Chats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.people_alt_rounded,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xFF1E5720),
                    size: 32,
                  ),
                  title: Text(
                    'Sign-out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
              _buildToggleOptionTile('Dark Mode', _darkMode),
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
          case 'Dark Mode':
            _darkMode = newValue;
            break;
        }
      });
    },
    activeColor: Color(0xff1E7251), // Color when toggle is enabled
    inactiveThumbColor: Color(0xff1E7251).withOpacity(0.3), // Color when toggle is disabled
    inactiveTrackColor: Color(0xff1E7251).withOpacity(0.3), // Color of the toggle track when toggle is disabled
  );
}


Widget _buildDeleteAccountButton() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 20),
    child: ElevatedButton(
      onPressed: _deleteAccount,
      child: Text(
        'Delete Account',
        style: TextStyle(color: Colors.red), // Set text color to red
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade50), // Yellow background color
      ),
    ),
  );
}

  void _deleteAccount() {
    // Implement the logic to delete the account
    // This function will be called when the "Delete Account" button is pressed
  }
}
