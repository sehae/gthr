import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gthr/main.dart';
import 'package:gthr/services/auth.dart';

import '../SignUpScreen/signup1.dart';

  class LoginScreen extends StatefulWidget {

    final void Function(bool, bool) toggleView;
    const LoginScreen({Key? key, required this.toggleView}) : super(key: key);

    @override
    _LoginScreen createState() => _LoginScreen();
  }

class _LoginScreen extends State<LoginScreen> {
  bool _showSignIn = true;
  final AuthService _auth = AuthService();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              child: Image.asset(
                'assets/gthr_Logo.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 48),
            TextFormField(
              onChanged: (val){
                setState(() => username = val);
              },
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              onChanged: (val){
                setState(() => password = val);
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    Text('Remember me'),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    print(username);
                    print(password);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                print(username);
                print(password);
              },
              child: Text(
                  'Login',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xff1E7251),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(color: Color(0xffFB5017), fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Register tapped");
                        widget.toggleView(false, false);
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
