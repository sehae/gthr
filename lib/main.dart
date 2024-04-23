import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gthr/navigation/drawer.dart';
import 'package:gthr/navigation/routing.dart';
import 'package:gthr/screens/ChatScreen/chat_main.dart';
import 'package:gthr/screens/EventScreen/events_main.dart';
import 'package:gthr/screens/FriendsScreen/friend_list.dart';
import 'package:gthr/screens/HomePage/homepage.dart';
import 'package:gthr/screens/ProfileScreen/profile_main.dart';
import 'package:gthr/screens/Settings/settings.dart';
import 'package:gthr/splash_screen.dart';
import 'selectionscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCdRjCVZlhrq72RuEklEyyxYlBRCYhI2Sw',
      projectId: 'gthr-b7547',
      appId: '1:417493490436:android:7df380d827c4419e14ce51',
      messagingSenderId: '417493490436',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        Routes.home: (context) => MyHomePage(),
        Routes.events: (context) => EventsPage(),
        Routes.chats: (context) => ChatPage(),
        Routes.friends: (context) => FriendsPage(),
        Routes.profile: (context) => ProfilePage(),
        Routes.settings: (context) => SettingsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
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
      extendBodyBehindAppBar: _selectedRoute == Routes.chats || _selectedRoute == Routes.friends,
      appBar: AppBar(
        title: Text(
            _getAppBarTitle(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: appBarColor == Colors.white ? Colors.black : Colors.white,
          ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logowtext.png', // GTHR LOGO
            ),
            SizedBox(height: 100), // Button to logo spacing
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectionScreen(),
                ));
              },
              child: Text('Get Started'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff1E7251), // BG color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(250, 50), // Button minimum size
              ),
            ),
          ],
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
              return HomePage();
            case Routes.events:
              return EventsPage();
            case Routes.chats:
              return ChatPage();
            case Routes.friends:
              return FriendsPage();
            case Routes.profile:
              return ProfilePage();
            case Routes.settings:
              return SettingsPage();
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
        return Color(0xff1E7251);
      case Routes.friends:
        return Color(0xff1E7251);
      case Routes.profile:
        return Colors.white;
      case Routes.settings:
        return Colors.white;
      default:
        return Color(0xff1E7251);
    }
  }

  List<Widget> _getActions() {
    if (_selectedRoute == Routes.events) {
      return [
        IconButton(
          icon: Image.asset('assets/gthr_LogoALT.png'),
          onPressed: (){
          },
        )
      ];
    } else if (_selectedRoute == Routes.friends) {
      return [
        IconButton(
          icon: Image.asset('assets/gthr_LogoALT.png'),
          onPressed: (){
          },
        )
      ];
    } else if (_selectedRoute == Routes.chats) {
      return [
        IconButton(
          icon: Image.asset('assets/gthr_LogoALT.png'),
          onPressed: (){
          },
        )
      ];
    } else if (_selectedRoute == Routes.profile) {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {

          },
        ),
      ];
    }
    return [];
  }
}
