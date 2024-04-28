import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gthr/services/auth.dart';

class SignUpScreen extends StatefulWidget {

  final Function toggleView;
  const SignUpScreen({super.key, required this.toggleView});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {

  final AuthService _auth = AuthService();

  String username = '';
  String email = '';
  String password = '';
  String uni = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TextFormField(
              onChanged: (val){
                setState(() => username = val);
              },
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (val){
                setState(() => email = val);
              },
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
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
            SizedBox(height: 15),
            TextFormField(
              onChanged: (val){
                setState(() => uni = val);
              },
              decoration: InputDecoration(
                labelText: 'University',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                widget.toggleView();
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xff1E7251), // text color
                minimumSize: Size(double.infinity, 50), // button size
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: 'Log In',
                    style: TextStyle(color: Color(0xffFB5017), fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        widget.toggleView();
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

  Widget _buildStepCircle(String number, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(number, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildLineConnector(List<Color> colors) {
    return Expanded(
      child: Container(
        height: 5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
