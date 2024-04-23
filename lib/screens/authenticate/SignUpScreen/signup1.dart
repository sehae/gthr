import 'package:flutter/material.dart';
import 'signup2.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildStepCircle('1', Color(0xff1E7251)), // HIGHLIGHTED SINCE STEP 1
                _buildLineConnector([Color(0xff1E7251), Color(0xffFFDD0A)]), // Gradient line from 1-2
                _buildStepCircle('2', Colors.grey), // Grey = not highlighted yet
                _buildLineConnector([Color(0xffFFDD0A), Color(0xffFF4E1A)]), // Gradient line from 2-3
                _buildStepCircle('3', Colors.grey),
              ],
            ),
            SizedBox(height: 20),
            Text('Personal Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            _buildTextField('First Name'),
            SizedBox(height: 15),
            _buildTextField('Last Name'),
            SizedBox(height: 15),
            _buildTextField('Date of Birth'),
            SizedBox(height: 15),
            _buildTextField('E-mail address'),
            SizedBox(height: 15),
            _buildTextField('Contact Number'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpStepTwoScreen()),
                );
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff1E7251), // bg color
                onPrimary: Colors.white, // text color
                minimumSize: Size(double.infinity, 50), // button size
              ),
            ),
          ],
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
