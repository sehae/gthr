import 'package:flutter/material.dart';
import 'package:gthr/screens/authenticate/LoginScreen/login.dart';
import 'package:gthr/screens/authenticate/SignUpScreen/signup1.dart';


class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context){
    if (showSignIn){
      return LoginScreen(toggleView: toggleView);
    } else {
      return SignUpScreen(toggleView: toggleView);
    }
  }
}
