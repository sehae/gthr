import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gthr/main.dart';
import 'package:gthr/services/auth.dart';

import '../SignUpScreen/signup1.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
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
                  onPressed: () {
                    // TODO: Implement forgot password logic
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
              onPressed: () async {
                dynamic result = _auth.signInAnon();
                if (result == null){
                  print("couldn't sign in");
                } else {
                  print('Signed In');
                  print(result + 'yes?');

                }
              },
              child: Text(
                  'Login',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff1E7251),
                onPrimary: Colors.white,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
