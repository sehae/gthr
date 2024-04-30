import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gthr/services/auth.dart';

import '../../../shared/loading.dart';

class SignUpScreen extends StatefulWidget {

  final void Function(bool, bool) toggleView;
  const SignUpScreen({super.key, required this.toggleView});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  String username = '';
  String fname = '';
  String lname = '';
  String email = '';
  String password = '';
  String uni = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter your First Name" : null,
                onChanged: (val){
                  setState(() => fname = val);
                },
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter your Last Name" : null,
                onChanged: (val){
                  setState(() => lname = val);
                },
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter a username" : null,
                onChanged: (val){
                  setState(() => username = val);
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val){
                  setState(() => email = val);
                },
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                onChanged: (val){
                  setState(() => password = val);
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter a University" : null,
                onChanged: (val){
                  setState(() => uni = val);
                },
                decoration: const InputDecoration(
                  labelText: 'University',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  setState(() => loading = true);
                  if (_formKey.currentState!.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(fname, lname, username, email, password);
                    if (result == null){
                      setState(() {
                        error = 'Please supply a valid email';
                        loading = false;
                      });
                    }
                  } else {
                    setState(() => loading = false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color(0xff1E7251), // text color
                  minimumSize: const Size(double.infinity, 50), // button size
                ),
                child: const Text('Sign Up'),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  children: <TextSpan>[
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: 'Log In',
                      style: const TextStyle(color: Color(0xffFB5017), fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.toggleView(true, true);
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
      child: Text(number, style: const TextStyle(color: Colors.white)),
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
        border: const OutlineInputBorder(),
      ),
    );
  }
}