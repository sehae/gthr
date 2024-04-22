import 'package:flutter/material.dart';
import 'routing.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Container(
          color: Color(0xFFC7CCCA),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Center(
                        child: Image.asset('assets/gthr_Logo.png'),
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
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        print("Tapped on Home");
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(context, Routes.home);
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
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.pushNamed(context, Routes.events);
                      },
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
                            fontWeight: FontWeight.bold
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
                            fontWeight: FontWeight.bold
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
                            fontWeight: FontWeight.bold
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
                            fontWeight: FontWeight.bold
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
                      fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () {
                  // Handle sign-out logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
