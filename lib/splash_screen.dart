import 'package:flutter/material.dart';
import 'package:gthr/screens/authenticate/SelectionScreen/selectionscreen.dart';
import 'package:gthr/screens/wrapper.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/gthr_LogoWithText.png',
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => Wrapper(),
                 ));
              },
              child: Text('Get Started'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1E7251)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(Size(250, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
