import 'package:flutter/material.dart';
import 'directMessages.dart';
import 'groupMessages.dart';
import 'chatUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatsMainPage(),
    );
  }
}

class ChatsMainPage extends StatefulWidget {
  @override
  _ChatsMainPageState createState() => _ChatsMainPageState();
}

class _ChatsMainPageState extends State<ChatsMainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E7251),
          title: Center(
            child: Text(
              'Chat',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          bottom: TabBar(
            // Tab bar at the bottom of AppBar
            labelColor: Color(0xFFDD09),
            labelStyle: TextStyle(color: Colors.white),
            tabs: [
              // Use Tab with label and icon for text and icon
              Tab(
                text: 'Direct', // Add text label for first tab
                icon: Icon(Icons.message),
              ),
              Tab(
                text: 'Groups', // Add text label for second tab
                icon: Icon(Icons.group),
              ),
            ],
          ),
        ),
        body: TabBarView(
          // Content for each tab
          children: [
            DirectMessagesScreen(),
            GroupMessagesScreen(),
          ],
        ),
      ),
    );
  }
}
