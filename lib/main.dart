import 'package:flutter/material.dart';
import 'selectionscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
    );
  }
}
