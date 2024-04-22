import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(FriendsPage());
}

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friend List Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Friends',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Image.asset('assets/gthr_LogoALT.png'),
              onPressed: (){
              },
            )
          ],
        ),
        drawer: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.5,
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
                        onTap: () {
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

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context){
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
                    if (selectedIndex == 0) buildListContent(),
                    if (selectedIndex == 1) buildRequestContent(),
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

  Widget buildContent(){
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildContentButton('List', 0),
          buildContentButton('Requests', 1),
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
                    )
                )
            ),
            child: TextButton(
              onPressed: (){
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
              child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                  )
              ),
            ),
          ),
        )
    );
  }

  Widget buildListContent(){
    return Column(
        children: [
          TextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(onPressed: (){
                  setState(() {
                    _controller.clear();
                  });
                },
                icon: FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                  size: 20,
                  color: Colors.black38,
                ),
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black12),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black12),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              fillColor: Colors.black12,
              filled: true,
            ),
          ),
        ]
    );
  }

  Widget buildRequestContent(){
    return Column(
        children: [
          TextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(onPressed: (){
                setState(() {
                  _controller.clear();
                });
              },
                icon: FaIcon(
                  FontAwesomeIcons.solidCircleXmark,
                  size: 20,
                  color: Colors.black38,
                ),
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black12),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black12),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              fillColor: Colors.black12,
              filled: true,
            ),
          ),
        ]
    );
  }
}