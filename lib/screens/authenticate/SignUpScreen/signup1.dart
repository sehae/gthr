import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gthr/services/auth.dart';
import 'package:gthr/shared/loading.dart';

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
  bool showPassword = false; // State for toggling password visibility

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
              buildTextField('First Name', 'Enter your First Name', validator: (val) => val!.isEmpty ? "Enter your First Name" : null),
              const SizedBox(height: 15),
              buildTextField('Last Name', 'Enter your Last Name', validator: (val) => val!.isEmpty ? "Enter your Last Name" : null),
              const SizedBox(height: 15),
              buildTextField('Username', 'Enter a username', validator: (val) => val!.isEmpty ? "Enter a username" : null),
              const SizedBox(height: 15),
              buildTextField('E-mail', 'Enter an email', validator: (val) => !RegExp(r'\S+@\S+\.\S+').hasMatch(val!) ? "Enter a valid email address" : null),
              const SizedBox(height: 15),
              buildTextField('Password', 'Enter a password 6+ chars long', obscureText: !showPassword, validator: validatePassword, togglePasswordView: true),
              const SizedBox(height: 15),
              buildTextField('University', 'Enter a University', validator: (val) => val!.isEmpty ? "Enter a University" : null),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(fname, lname, username, email, password, uni);
                    if (result == null) {
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
                  foregroundColor: Colors.white, backgroundColor: const Color(0xff1E7251),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  children: <TextSpan>[
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: 'Log In',
                      style: const TextStyle(color: Color(0xffFB5017), fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                      recognizer: TapGestureRecognizer()..onTap = () {
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

  Widget buildTextField(String label, String errorMessage, {bool obscureText = false, String? Function(String?)? validator, bool togglePasswordView = false}) {
    return TextFormField(
      validator: validator,
      onChanged: (val){
        setState(() => {
          if (label == 'First Name') fname = val,
          if (label == 'Last Name') lname = val,
          if (label == 'Username') username = val,
          if (label == 'E-mail') email = val,
          if (label == 'Password') password = val,
          if (label == 'University') uni = val
        });
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        border: InputBorder.none,
        fillColor: Colors.black12,
        filled: true,
        suffixIcon: togglePasswordView ? IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ) : null,
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a password";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
      return "Password must have at least one uppercase letter";
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
      return "Password must have at least one lowercase letter";
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
      return "Password must have at least one number";
    } else if (!RegExp(r'(?=.*?[!@#\$&*~]).{6,}').hasMatch(value)) {
      return "Password must have at least one special character";
    }
    return null;
  }
}
