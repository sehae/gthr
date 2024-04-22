import 'package:flutter/material.dart';
import 'package:gthr/screens/EventScreen/events_main.dart';
import 'package:gthr/screens/FriendsScreen/friend_list.dart';
import 'package:gthr/screens/ProfileScreen/profile_main.dart';
import 'package:gthr/screens/Settings/settings.dart';

class AppRoutes {
  static const String home = '/';
  static const String events = '/events';
  static const String chats = '/chats';
  static const String friends = '/friends';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes {
    return {
      //home: (context) => HomePage(),
      events: (context) => EventsPage(),
      //chats: (context) => ChatsPage(),
      friends: (context) => FriendsPage(),
      profile: (context) => ProfilePage(),
      settings: (context) => SettingsPage(),
    };
  }
}
