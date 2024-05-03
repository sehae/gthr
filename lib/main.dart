import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gthr/models/user.dart';
import 'package:gthr/navigation/drawer.dart';
import 'package:gthr/navigation/routing.dart';
import 'package:gthr/screens/ChatScreen/chat_main.dart';
import 'package:gthr/screens/EventScreen/events_main.dart';
import 'package:gthr/screens/FriendsScreen/friend_list.dart';
import 'package:gthr/screens/HomePage/homepage.dart';
import 'package:gthr/screens/ProfileScreen/profile_main.dart';
import 'package:gthr/screens/Settings/settings.dart';
import 'package:gthr/services/auth.dart';
import 'package:gthr/shared/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCzPxlFUts9o9i6tx6BSOZPXAgMjttHyIs',
      projectId: 'gthr-b7547',
      appId: '1:417493490436:android:7df380d827c4419e14ce51',
      messagingSenderId: '417493490436',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<myUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          scrollbarTheme: ScrollbarThemeData(
            thickness: MaterialStateProperty.all(6.0),
            minThumbLength: 25.0,
            radius: Radius.circular(15.0),
            thumbColor: MaterialStateProperty.all(Color(0xff1E7251)),
          ),

        ),
        home: const SplashScreen(), //Wrapper(), //
        routes: {
          Routes.home: (context) => const MyHomePage(),
          Routes.events: (context) => const EventsPage(),
          Routes.chats: (context) => const ChatPage(),
          Routes.friends: (context) => const FriendsPage(),
          Routes.profile: (context) => const ProfilePage(),
          Routes.settings: (context) => const SettingsPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedRoute = Routes.home;

  void _onSelectRoute(String route) {
    setState(() {
      _selectedRoute = route;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color appBarColor = _getAppBarColor();

    return Scaffold(
      extendBodyBehindAppBar:
          _selectedRoute == Routes.chats || _selectedRoute == Routes.friends,
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: appBarColor == Colors.white ? Colors.black : Colors.white,
          ),
        ),
        backgroundColor: _getAppBarColor(),
        actions: _getActions(),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        onSelectRoute: _onSelectRoute,
        selectedRoute: _selectedRoute,
      ),
      body: Builder(
        builder: (BuildContext context) {
          switch (_selectedRoute) {
            case Routes.home:
              return const HomePage();
            case Routes.events:
              return const EventsPage();
            case Routes.chats:
              return const ChatPage();
            case Routes.friends:
              return const FriendsPage();
            case Routes.profile:
              return const ProfilePage();
            case Routes.settings:
              return const SettingsPage();
            default:
              return Container();
          }
        },
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedRoute) {
      case Routes.home:
        return '';
      case Routes.events:
        return 'Events';
      case Routes.chats:
        return 'Chats';
      case Routes.friends:
        return 'Friends';
      case Routes.profile:
        return '';
      case Routes.settings:
        return 'Settings';
      default:
        return '';
    }
  }

  Color _getAppBarColor() {
    switch (_selectedRoute) {
      case Routes.home:
        return Colors.white;
      case Routes.events:
        return Colors.white;
      case Routes.chats:
        return const Color(0xff1E7251);
      case Routes.friends:
        return const Color(0xff1E7251);
      case Routes.profile:
        return Colors.white;
      case Routes.settings:
        return Colors.white;
      default:
        return const Color(0xff1E7251);
    }
  }

  List<Widget> _getActions() {
    if (_selectedRoute == Routes.events) {
      return [
        IconButton(
          icon: Image.asset('assets/gthr_LogoALT.png'),
          onPressed: () {},
        )
      ];
    } else if (_selectedRoute == Routes.friends) {
      return [
        IconButton(
          icon: Image.asset('assets/gthr_LogoALT.png'),
          onPressed: () {},
        )
      ];
    } else if (_selectedRoute == Routes.chats) {
      return [
        IconButton(
          icon: Image.asset('assets/gthr_LogoALT.png'),
          onPressed: () {},
        )
      ];
    } else if (_selectedRoute == Routes.profile) {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ];
    }
    return [];
  }
}
