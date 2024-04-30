import 'package:flutter/material.dart';
import 'package:gthr/screens/EventsTab/events_tab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final List<String> imgList = [
    'https://www.tip.edu.ph/assets/genericpage/images/Olymphysics-QC-960-x-640.png',
    'https://www.ucf.edu/wp-content/blogs.dir/19/files/2021/02/Event-Planning-Tips-Tools-and-Resources-for-Security-and-Success-01.jpg',
    'https://images.lumacdn.com/cdn-cgi/image/format=auto,fit=cover,dpr=2,quality=75,width=400,height=400/event-covers/s5/74a15289-20a5-4f6b-8802-bff4935239da',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnCLSHaQslFi-xjsavT7jHsRORYa7mEKqJ6ENlyzk0Ug&s',
  ];

  int _currentIndex = 0;

  String selectedOrganization = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F0),
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF1E7251), // Set separate color for AppBar
        elevation: 0,
        title: Text(
          'Find events for you',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Set color of the pop button to white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'assets/gthr_LogoALT.png',
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              children: [
                Container(
                  color: const Color(0xFF1E7251),
                  height: 65.0,
                  width: 411,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your location',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'TIP QC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: DropdownButton<String>(
              value: selectedOrganization,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOrganization = newValue!;
                });
              },
              items: <String>['All', 'JDSAAP', 'JPCS', 'ACM', 'MCUBE']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text(
                  'Latest events',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EventsTab(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text(
                      'Browse full list',
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color(0xFF1E7251),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              width: 350.0,
              height: 50.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  print('Searching for events: $value');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20.0),
            child: Stack(
              children: [
                CarouselSlider(
                  items: imgList
                      .map((e) =>
                          Container(child: Center(child: Image.network(e))))
                      .toList(),
                  options: CarouselOptions(
                    height: 300,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Color(0xFF1E7251)
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
