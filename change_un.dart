import 'package:flutter/material.dart';

class ChangeUsernamePage extends StatefulWidget {
  final String currentUsername;

  ChangeUsernamePage({Key? key, required this.currentUsername}) : super(key: key);

  @override
  _ChangeUsernamePageState createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentUsername);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Username'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current', style: TextStyle(color: Colors.grey)),
            Text(widget.currentUsername, style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 20),
            Text('New', style: TextStyle(color: Colors.grey)),
            TextField(
              controller: _controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffFB5017))),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty && _controller.text != widget.currentUsername) {
                  // Implement your update logic here
                  Navigator.pop(context);
                } else {
                  // Optionally handle validation or show an error
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No changes made or new username is empty'))
                  );
                }
              },
              child: Text('Done', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xff1E7251)),
            )
          ],
        ),
      ),
    );
  }
}
