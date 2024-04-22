import 'package:flutter/material.dart';
import 'package:gthr/navigation/drawer.dart';
import 'package:gthr/navigation/navDrawer.dart';
import 'package:gthr/navigation/routing.dart';
import 'package:readmore/readmore.dart';

class EventsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events Main Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
  String text = 'Lorem ipsum dolor sit amet consectetur. Volutpat ac pulvinar egestas id vitae. Risus lacinia ac aliquam bibendum viverra facilisis id. Neque nisi pharetra quis ultrices habitasse vivamus leo. Ultricies morbi in morbi non.Lorem ipsum dolor sit amet consectetur. Volutpat ac pulvinar egestas id vitae. Risus lacinia ac aliquam bibendum viverra facilisis id. Neque nisi pharetra quis ultrices habitasse vivamus leo. Ultricies morbi in morbi non.';

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    buildEventImage(),
                    buildEventDetails(),
                    buildExpandedDetails(),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget buildEventImage() => Center(
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
      ],
    ),
  );

  Widget buildEventDetails() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: Icon(Icons.star),
                    label: Text('Interested'),
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
              ),
              SizedBox(width: 10),
              Container(
                width: 97,
                child: Expanded(
                  child: FittedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Icon(Icons.check),
                      label: Text('Going'),
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
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 10)),
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
      ],
    );
  }

  Widget buildExpandedDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContentButton('About', 0),
            SizedBox(width: 10),
            buildContentButton('Discussion', 1),
          ],
        ),
        if (selectedIndex == 0) buildAboutContent(),
        if (selectedIndex == 1) buildDiscussionContent(),
      ],
    );
  }

  Widget buildContentButton(String text, int index) {
    final isActive = selectedIndex == index;

    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Text(
          text,
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
              isActive ? Color(0xFF787878) : Color(0xFFD9D9D9)
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
              isActive ? Color(0xFFFFFFFF) : Color(0xFF2C2C30)
          ),

        ),
      ),
    );
  }

  Widget buildAboutContent() => Column(
    children: <Widget> [
      buildMAINAboutContent(),
      buildGuestSpeaker(),
    ],
  );

  Widget buildMAINAboutContent() => Container(
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
      ],
    ),
  );

  Widget buildGuestSpeaker() => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
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
  );

  Widget buildDiscussionContent() => Container(
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
  );
}