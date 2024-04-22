import 'package:flutter/material.dart';

void main() {
  runApp(ChatPage());
}

class ChatPage extends StatelessWidget {
  //final String userEmail;
  //final String receiverUserID;
  //const MyApp({super.key,
  //required this.receiverUserEmail,
  //required this.receiverUserID,
  //});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Content(),
      ),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final double headerHeight = 180;

  int selectedIndex = 0;

  _ContentState() {
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (selectedIndex == 0) buildMessagesContent(),
                    if (selectedIndex == 1) buildGroupsContent(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: Color(0xFF1E7251),
      height: headerHeight,
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildContent(),
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildContentButton('Messages', 0),
          buildContentButton('Groups', 1),
        ],
      ),
    );
  }

  Widget buildContentButton(String text, int index) {
    final isActive = selectedIndex == index;

    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: isActive ? Color(0xFFFFDD0A) : Colors.transparent,
                      width: 5.0,
                    ))),
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return Colors.transparent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white.withOpacity(0.8);
                    }
                    return isActive ? Colors.white : Colors.white;
                  },
                ),
              ),
              child: Text(text,
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ),
          ),
        ));
  }

  Widget buildMessagesContent() {
    return Column(
      children: [
        Center(
          child: Text('Loading messages...'),
        ),
      ],
    );
  }

  Widget buildGroupsContent() {
    return Column(
      children: [
        Center(
          child: Text('Loading groups...'),
        ),
      ],
    );
  }
}