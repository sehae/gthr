import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Color(0xFF1E7251)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => CreatePostScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(0.0, 1.0);  // Start from the bottom
                      var end = Offset.zero;  // End at the center
                      var curve = Curves.easeInOut;  // Use an ease-in-out curve for smooth animation

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 300), // Customize the duration of the transition
                  ),
                );
              },
              child: Text('Post', style: TextStyle(color: Color(0xFF1E7251), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image URL
                  radius: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "What's poppin'?",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
