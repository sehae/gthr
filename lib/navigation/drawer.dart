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
                        Navigator.pushNamed(context, AppRoutes.home);
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
                        Navigator.pushNamed(context, AppRoutes.events);
                      },
                    ),
                    // Add similar ListTile widgets for other screens
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
