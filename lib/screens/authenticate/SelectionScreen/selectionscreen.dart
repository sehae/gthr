import 'package:flutter/material.dart';

import '../../../services/auth.dart';
import '../LoginScreen/login.dart';

class SelectionScreen extends StatefulWidget {
  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    //Minimum screen width and 1/2 screen height to make sure shit squares up
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width;
    final buttonHeight = size.height / 2;

    final buttonSize = Size(
      buttonWidth,
      buttonHeight,
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            width: buttonSize.width,
            height: buttonSize.height,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xffFFDD0A), backgroundColor: Color(0xff1E7251),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.school, size: 80), // Primary color = Yellow primary color = yellow icon
                      Text('I am a STUDENT',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: buttonSize.width,
            height: buttonSize.height,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xff1E7251),
                backgroundColor: Color(0xffFFDD0A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null){
                  print("couldn't sign in");
                } else {
                  print('Signed In');
                  print(result.uid);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people, size: 80), // Green primary color = green icon
                  Text('I am a GUEST',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
