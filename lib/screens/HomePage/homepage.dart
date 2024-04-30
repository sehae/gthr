import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Welcome, User!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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
                      'Upcoming Events',
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
              _buildCard(
                imageUrl: 'assets/event_1.jpg',
                title: 'InnovatED Fair',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Adjusting vertical padding
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
              _buildCard(
                imageUrl: 'assets/event_2.jpg',
                title: 'PasKorner',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), // Adjusting vertical padding
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
              _buildAnnouncement(
                profileImageUrl: 'assets/user_1.jpg',
                name: 'Johan Santos',
                date: 'April 16, 2024',
                time: '10:00 AM',
                announcementText:
                'LF ka-duo sa valo, babae only',
              ),
            ],
          ),
        ),
      ),
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
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(profileImageUrl),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$date | $time',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    announcementText,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
