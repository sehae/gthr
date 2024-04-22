import 'package:flutter/material.dart';

class SignUpStepThreeScreen extends StatefulWidget {
  @override
  _SignUpStepThreeScreenState createState() => _SignUpStepThreeScreenState();
}

class _SignUpStepThreeScreenState extends State<SignUpStepThreeScreen> {
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
                _buildStepCircle('1', Color(0xff1E7251)), // Completed steps are highlighted
                _buildLineConnector([Color(0xff1E7251), Color(0xffFFDD0A)]), // Gradient from 1-2
                _buildStepCircle('2', Color(0xffFFDD0A)),
                _buildLineConnector([Color(0xffFFDD0A), Color(0xffFF4E1A)]), // Gradient from 2-3
                _buildStepCircle('3', Color(0xffFF4E1A)),
              ],
            ),
            SizedBox(height: 20),
            Text('School Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            _buildTextField('University'),
            SizedBox(height: 15),
            _buildTextField('Address'),
            SizedBox(height: 15),
            _buildTextField('City'),
            SizedBox(height: 15),
            _buildTextField('ZIP Code'),
            SizedBox(height: 15),
            _buildTextField('Year Level'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement submission logic
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff1E7251), // BG color
                onPrimary: Colors.white, // Text color
                minimumSize: Size(double.infinity, 50), // Button size
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
