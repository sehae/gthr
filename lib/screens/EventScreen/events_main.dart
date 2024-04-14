import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events Main Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Events'),
        ),
        drawer: Drawer(
          child: Container(
            color: Color(0xFFC7CCCA),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Image.asset('assets/'),
                  ),
                )
              ],
            ),
          ),
        ),
        body: content(),
      ),
    );
  }
}

class content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );
  }
}
