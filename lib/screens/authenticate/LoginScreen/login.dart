import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gthr/main.dart';
import 'package:gthr/services/auth.dart';

import '../../../shared/loading.dart';
import '../SignUpScreen/signup1.dart';

  class LoginScreen extends StatefulWidget {

    final void Function(bool, bool) toggleView;
    const LoginScreen({Key? key, required this.toggleView}) : super(key: key);

    @override
    _LoginScreen createState() => _LoginScreen();
  }

class _LoginScreen extends State<LoginScreen> {

  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  String username = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              validator: (val) => val!.isEmpty ? "Enter an email" : null,
              onChanged: (val){
                setState(() => email = val);
              },
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
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
                    print(email);
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
              onPressed: () async {
                if (_formKey.currentState!.validate()){
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null){
                    setState(() {
                      error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS';
                      loading = false;
                    });
                  }
                }
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
