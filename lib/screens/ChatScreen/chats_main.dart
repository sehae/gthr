import 'package:flutter/material.dart';
import 'directMessages.dart';
import 'groupMessages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatsMainPage(),
    );
  }
}

class ChatsMainPage extends StatefulWidget {
  const ChatsMainPage({super.key});

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
          backgroundColor: const Color(0xFF1E7251),
          title: const Center(
            child: Text(
              'Chat',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          bottom: const TabBar(
            // Tab bar at the bottom of AppBar
            labelColor: Color(0x00ffdd09),
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
            const GroupMessagesScreen(),
          ],
        ),
      ),
    );
  }
}
