import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gthr/screens/EventScreen/events_main.dart';
import 'package:gthr/screens/HomePage/homepage.dart';

class navDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  final Function(String) onSelectRoute;
  final String selectedRoute;
  final BuildContext context;

  navDrawer({
    required this.context,
    required this.onSelectRoute,
    required this.selectedRoute
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Container(
          color: Color(0xFFC7CCCA),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: Center(
                        child: Image.asset('assets/gthr_Logo.png'),
                      ),
                    ),
                    buildMenuItem(
                      text: 'Home',
                      icon: Icons.home,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    buildMenuItem(
                      text: 'Events',
                      icon: Icons.event,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    buildMenuItem(
                      text: 'Chats',
                      icon: Icons.chat_bubble,
                    ),
                    buildMenuItem(
                      text: 'Friends',
                      icon: Icons.people_alt_rounded,
                    ),
                    buildMenuItem(
                      text: 'Profile',
                      icon: Icons.person,
                    ),
                    buildMenuItem(
                      text: 'Settings',
                      icon: Icons.settings,
                    ),
                  ],
                ),
              ),
              buildMenuItem(
                text: 'Logout',
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildMenuItem ({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xFF1E5720),
        size: 32,
      ),
      title: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventsPage(),
        ));
        break;
    }
  }
}