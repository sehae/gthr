import 'package:flutter/material.dart';
import 'package:gthr/screens/authenticate/LoginScreen/login.dart';
import 'package:gthr/screens/authenticate/SignUpScreen/signup1.dart';

import 'SelectionScreen/selectionscreen.dart';
import '../../../services/auth.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final AuthService _auth = AuthService();
  bool showSignIn = true;
  bool _showSelectionScreen = true;

  void _toggleSelection(bool showSelection) {
    setState(() {
      _showSelectionScreen = showSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSelectionScreen
        ? SelectionScreen(
      onLoginSelected: () {
        _toggleSelection(false);
      },
      onGuestSignInSelected: () async {
        dynamic result = await _auth.signInAnon();
        if (result == null) {
          print("Couldn't sign in");
        } else {
          print('Signed In');
          print(result.uid);
        }
      },
    )
        : _buildAuthenticationScreen();
  }

  Widget _buildAuthenticationScreen() {
    return showSignIn ? LoginScreen(toggleView: _toggleSelection) : SignUpScreen(toggleView: _toggleSelection);
  }
}
