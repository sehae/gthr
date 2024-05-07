import 'package:flutter/material.dart';
import 'package:gthr/services/database.dart';
import 'package:gthr/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../shared/custom_scrollbar.dart';
import '../EventScreen/upcoming_events.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          print('data received');
          return Scaffold(
            body: CustomScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Text(
                              'Welcome, ${userData!.fname}!',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Announcements',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    _buildAnnouncement(
                      profileImageUrl: 'assets/user_1.jpg',
                      name: 'Karina Sanchez',
                      date: 'April 30, 2024',
                      time: '10:30 AM',
                      announcementText: 'Attention all Quiz Buzz winners, please proceed to Room 5216 to collect your prizes. Thank you.',
                    ),
                    _buildAnnouncement(
                      profileImageUrl: 'assets/user_2.png',
                      name: 'Jm Tan',
                      date: 'May 2, 2024',
                      time: '8:03 AM',
                      announcementText: 'The Sci-Tech Fair is postponed to May 13, 2024. Apologies for the inconvenience.',
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Upcoming Events',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const UpcomingEvents(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var tween = Tween(begin: begin, end: end);
                                    var offsetAnimation = animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'See more...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 230, // Adjust the height of the card
                      child: CardCarousel(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Past Events',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle "See more..." button press
                            },
                            child: const Text(
                              'See more...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 230, // Adjust the height of the card
                      child: CardCarousel2(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          print('not received');
          return Loading();
        }
      },
    );
  }
  Widget _buildCard({required String imageUrl, required String title}) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Stack(
        children: [
          Container(
            height: 185,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 185,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildAnnouncement({
    required String profileImageUrl,
    required String name,
    required String date,
    required String time,
    required String announcementText,
  }) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color(0xFF1E5720).withOpacity(0.8), // Adjust opacity as needed
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 1, 10), // Adjust padding for smaller announcements
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25, // Reduce avatar size
                  backgroundImage: AssetImage(profileImageUrl),
                ),
                const SizedBox(width: 10), // Reduce spacing between avatar and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16, // Reduce font size for name
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Adjust text color for better visibility
                        ),
                      ),
                      const SizedBox(height: 3), // Reduce spacing between name and date
                      Text(
                        '$date, $time', // Format date and time
                        style: const TextStyle(
                          fontSize: 14, // Reduce font size for date and time
                          color: Colors.white70, // Adjust text color for better visibility
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5), // Reduce spacing between date and announcement text
            Text(
              announcementText,
              maxLines: 2, // Limit announcement text to 2 lines for smaller size
              overflow: TextOverflow.ellipsis, // Truncate text if it exceeds 2 lines
              style: const TextStyle(
                fontSize: 14, // Reduce font size for announcement text
                color: Colors.white, // Adjust text color for better visibility
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CardCarousel extends StatelessWidget {
  final List<Map<String, String>> imageData = [
    {'imagePath': 'assets/event_1.jpg', 'title': 'InnovatED Fair'},
    {'imagePath': 'assets/event_4.jpg', 'title': 'Cyber Security Buff'},
    {'imagePath': 'assets/event_5.jpg', 'title': 'Data X'},
    {'imagePath': 'assets/event_6.jpg', 'title': 'Clay Workshop'},
    // Add more image paths and titles as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 230, // Adjust the height of the carousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.7, // Adjust the width of the card
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imageData[index]['imagePath']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Text(
                    imageData[index]['title']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class CardCarousel2 extends StatelessWidget {
  final List<Map<String, String>> imageData = [
    {'imagePath': 'assets/event_2.jpg', 'title': 'PASKOrner'},
    {'imagePath': 'assets/event_3.jpg', 'title': 'Beyond the Surface'},
    {'imagePath': 'assets/event_7.jpg', 'title': 'The UI/UX Challenge'},
    // Add more image paths and titles as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 230, // Adjust the height of the carousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.7, // Adjust the width of the card
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imageData[index]['imagePath']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Text(
                    imageData[index]['title']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
