import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool showAboutContainer = false;
  bool showDiscussionContainer = true;
  bool showFeedback = false;
  bool scaleAnswer = false;
  String text = 'Lorem ipsum dolor sit amet consectetur. Volutpat ac pulvinar egestas id vitae. Risus lacinia ac aliquam bibendum viverra facilisis id. Neque nisi pharetra quis ultrices habitasse vivamus leo. Ultricies morbi in morbi non.Lorem ipsum dolor sit amet consectetur. Volutpat ac pulvinar egestas id vitae. Risus lacinia ac aliquam bibendum viverra facilisis id. Neque nisi pharetra quis ultrices habitasse vivamus leo. Ultricies morbi in morbi non.';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
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
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                showFeedback = true;
                              });
                            },
                            icon: Icon(Icons.feedback),
                            label: Text(
                              'Review',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 10)),
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
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                CircleAvatar(
                                  minRadius: 15,
                                  maxRadius: 15,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  '9 People are Interested',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
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
                            SizedBox(height: 5,),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 70,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Feb',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF2C2C30),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '26',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF2C2C30),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 70,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          '10:30am',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF2C2C30),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '11:30am',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF2C2C30),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showAboutContainer = true;
                                showDiscussionContainer = false;
                              });
                            },
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 30)),
                              maximumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  showAboutContainer ? Color(0xFF787878) : Color(0xFFD9D9D9)
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  showAboutContainer ? Color(0xFFFFFFFF) : Color(0xFF2C2C30)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showDiscussionContainer = true;
                                showAboutContainer = false;
                              });
                            },
                            child: Text(
                              'Discussion',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 30)),
                              maximumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  showDiscussionContainer ? Color(0xFF787878) : Color(0xFFD9D9D9)
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  showDiscussionContainer ? Color(0xFFFFFFFF) : Color(0xFF2C2C30)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (showAboutContainer)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Event',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            ReadMoreText(
                              text,
                              trimLines: 5,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read More.',
                              trimExpandedText: 'Read Less.',
                              moreStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E7251),
                                decoration: TextDecoration.underline,
                              ),
                              lessStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E7251),
                                decoration: TextDecoration.underline,
                              ),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Additional Content: if the event has guest speakers/special artist.
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Guest Speaker',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        minRadius: 30,
                                        maxRadius: 30,
                                      ),
                                      SizedBox(width: 20,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Shrek de Swamp',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Former President of ACM',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (showDiscussionContainer)
                      Container(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: (){
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 10)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD9D9D9)),
                                foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF2C2C30)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sort By: Recent Activity',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 35,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          if (showFeedback)
            Positioned.fill(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    showFeedback = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                          width: 350,
                          height: 450,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Give Feedback',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                      'How would you describe your experience at the event?*',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          child: ElevatedButton(
                                            onPressed: (){
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                EdgeInsets.all(15),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F3F3)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1E7251)),
                                            ),
                                            child: Column(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.faceSadTear,
                                                  size: 60,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Text(
                                                    'Terrible',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: FittedBox(
                                          child: ElevatedButton(
                                            onPressed: (){
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                EdgeInsets.all(15),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F3F3)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1E7251)),
                                            ),
                                            child: Column(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.faceFrown,
                                                  size: 60,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Text(
                                                    'Bad',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: FittedBox(
                                          child: ElevatedButton(
                                            onPressed: (){
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                EdgeInsets.all(15),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F3F3)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1E7251)),
                                            ),
                                            child: Column(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.faceMeh,
                                                  size: 60,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Text(
                                                    'Okay',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: FittedBox(
                                          child: ElevatedButton(
                                            onPressed: (){
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                EdgeInsets.all(15),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F3F3)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1E7251)),
                                            ),
                                            child: Column(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.faceSmile,
                                                  size: 60,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Text(
                                                    'Good',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: FittedBox(
                                          child: ElevatedButton(
                                            onPressed: (){
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                EdgeInsets.all(15),
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F3F3)),
                                              foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1E7251)),
                                            ),
                                            child: Column(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.faceLaugh,
                                                  size: 60,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Text(
                                                    'Amazing',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Feel free to share any additional feedback or comments.',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  TextField(
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Tell us how can we improve',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFC5C5C5)
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1E7251),
                                          width: 5.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){

                                        },
                                        child: Text(
                                            'Submit'
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: (){

                                        },
                                        child: Text(
                                            'Cancel'
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    )
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}