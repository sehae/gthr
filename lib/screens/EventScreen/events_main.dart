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
          title: Text(
              'Events',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Image.asset('assets/gthr_LogoALT.png'),
              onPressed: (){
              },
            )
          ],
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Container(
            color: Color(0xFFC7CCCA),
            child: Column(
              children: [
                Expanded(
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
                          size: 32,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
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
                          size: 32,
                        ),
                        title: Text(
                          'Events',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.chat_bubble,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Chats',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.people_alt_rounded,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Friends',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Color(0xFF1E5720),
                          size: 32,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xFF1E5720),
                    size: 32,
                  ),
                  title: Text(
                    'Sign-out',
                    style: TextStyle(
                        fontSize: 20,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Content(),
      ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xFF1E7251).withOpacity(0.4),
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    'assets/test.png',
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(Icons.star),
                        label: Text('Interested'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFDD09)),
                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF2C2C30)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 100,
                    child: Expanded(
                      child: FittedBox(
                        child: ElevatedButton.icon(
                          onPressed: () {
                          },
                          icon: Icon(Icons.check),
                          label: Text('Going'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD9D9D9)),
                            foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF2C2C30)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FittedBox(
                      child: ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(Icons.close),
                        label: Text('Not Going'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD9D9D9)),
                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF2C2C30)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Code Revibe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'By ACM',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '9 People are Interested',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xFF2C2C30),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'Building 9',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 20,
                            color: Color(0xFF2C2C30),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'Open for TIPQC Students',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Center(
                          child: Text(
                            'Feb 26',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2C2C30),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Center(
                          child: Text(
                            '10:30am',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2C2C30),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('About'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 30)),
                        maximumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF787878)),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Text('Discussion'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 30)),
                        maximumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD9D9D9)),
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF2C2C30)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'About Event'
                  ),
                  Text(
                      'Lorem ipsum dolor sit amet consectetur. Volutpat ac pulvinar egestas id vitae. Risus lacinia ac aliquam bibendum viverra facilisis id. Neque nisi pharetra quis ultrices habitasse vivamus leo. Ultricies morbi in morbi non.'
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Guest Speaker'
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}