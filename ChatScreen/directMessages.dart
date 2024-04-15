import 'package:flutter/material.dart';
import 'chats_main.dart';
import 'groupMessages.dart';

class DirectMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title property removed
          ),
      body: Center(
        child: Text('This is the Direct Messages Screen'),
      ),
    );
  }
}
