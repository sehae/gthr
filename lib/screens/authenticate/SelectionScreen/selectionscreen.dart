import 'package:flutter/material.dart';

import '../../../services/auth.dart';
import '../../../shared/loading.dart';
class SelectionScreen extends StatefulWidget {
  final VoidCallback onLoginSelected;
  final VoidCallback onGuestSignInSelected;

  const SelectionScreen({super.key, required this.onLoginSelected, required this.onGuestSignInSelected});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    //Minimum screen width and 1/2 screen height to make sure shit squares up
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width;
    final buttonHeight = size.height / 2;

    final buttonSize = Size(
      buttonWidth,
      buttonHeight,
    );

    return loading ? const Loading() : Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            width: buttonSize.width,
            height: buttonSize.height,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xffFFDD0A), backgroundColor: const Color(0xff1E7251),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: widget.onLoginSelected,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.school, size: 80), // Primary color = Yellow primary color = yellow icon
                  Text('I am a STUDENT',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: buttonSize.width,
            height: buttonSize.height,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff1E7251),
                backgroundColor: const Color(0xffFFDD0A),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                setState(() {
                  loading = true;
                });
                widget.onGuestSignInSelected();
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people, size: 80), // Green primary color = green icon
                  Text('I am a GUEST',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}