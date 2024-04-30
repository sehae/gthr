import 'package:flutter/material.dart';
import 'package:gthr/services/auth.dart';
import 'routing.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onSelectRoute;
  final String selectedRoute;
  final AuthService _auth = AuthService();

  AppDrawer({super.key, 
    required this.onSelectRoute,
    required this.selectedRoute
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: Container(
          color: const Color(0xFFC7CCCA),
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
                      leading: const Icon(
                        Icons.home,
                        color: Color(0xFF1E5720),
                        size: 32,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        onSelectRoute(Routes.home);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.event,
                        color: Color(0xFF1E5720),
                        size: 32,
                      ),
                      title: const Text(
                        'Events',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        onSelectRoute(Routes.events);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.chat_bubble,
                        color: Color(0xFF1E5720),
                        size: 32,
                      ),
                      title: const Text(
                        'Chats',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        onSelectRoute(Routes.chats);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.people_alt_rounded,
                        color: Color(0xFF1E5720),
                        size: 32,
                      ),
                      title: const Text(
                        'Friends',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        onSelectRoute(Routes.friends);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Color(0xFF1E5720),
                        size: 32,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        onSelectRoute(Routes.profile);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: Color(0xFF1E5720),
                        size: 32,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        onSelectRoute(Routes.settings);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Color(0xFF1E5720),
                  size: 32,
                ),
                title: const Text(
                  'Sign-out',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
