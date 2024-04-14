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
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Container(
            color: Color(0xFFC7CCCA),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Image.asset('assets/gthr_Logo.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.home,
                    color: Color(0xFF1E5720),
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: (){
                    'Navigator.of(context).push('
                        'MaterialPageRoute(builder: (context)=> homepage())'
                        ')';
                  },
                ),
                ListTile(
                  leading: Icon(
                      Icons.event,
                    color: Color(0xFF1E5720),
                  ),
                  title: Text(
                    'Events',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.chat_bubble,
                    color: Color(0xFF1E5720),
                  ),
                  title: Text(
                    'Chats',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.people_alt_rounded,
                    color: Color(0xFF1E5720),
                  ),
                  title: Text(
                    'Friends',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.person,
                    color: Color(0xFF1E5720),
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.settings,
                    color: Color(0xFF1E5720),
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
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
