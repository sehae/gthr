import 'package:flutter/material.dart';
import 'package:gthr/navigation/routing.dart';
import 'package:gthr/screens/EventScreen/events_main.dart';
import 'package:gthr/screens/FriendsScreen/friend_list.dart';
import 'package:gthr/screens/HomePage/homepage.dart';
import 'package:gthr/screens/ProfileScreen/profile_main.dart';
import 'package:gthr/screens/Settings/settings.dart';
import 'package:gthr/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define routes
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.home:
            return MaterialPageRoute(builder: (context) => HomePage());
          case Routes.events:
            return MaterialPageRoute(builder: (context) => EventsPage());
          case Routes.chats:
            //return MaterialPageRoute(builder: (context) => ChatsScreen());
          case Routes.friends:
            return MaterialPageRoute(builder: (context) => FriendsPage());
          case Routes.profile:
            return MaterialPageRoute(builder: (context) => ProfilePage());
          case Routes.settings:
            return MaterialPageRoute(builder: (context) => SettingsPage());
          case Routes.splash: // Assuming you have a SplashScreen
            return MaterialPageRoute(builder: (context) => SplashScreen());
          default:
            return null; // If the route is not found, return null
        }
      },
      // Set the initial route
      initialRoute: Routes.splash, // Assuming SplashScreen is your initial route
    );
  }
}
