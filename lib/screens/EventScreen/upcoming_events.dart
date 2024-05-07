import 'package:flutter/material.dart';
import 'package:gthr/screens/EventScreen/event_details.dart';
import 'package:intl/intl.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  // Define lists for event data
  final List<String> eventTitles = [
    'Code Revibe',
    'Flutter Workshop for Beginners',
    'Game Development with Unity',
    'Hackathon: Building the Future',
    'Design Thinking Masterclass',
    'Public Speaking Workshop',
  ];

  final List<String> clubNames = [
    'ACM',
    'JDSAAP',
    'JPCS',
    'ACM',
    'MCube',
    'Entrep Club',
  ];

  final List<String> descriptions = [
    'Get ready to catch the 𝘾𝙤𝙙𝙚 𝙍𝙚𝙫𝙞𝙗𝙚! 🎉 Join us for the upcoming General Assembly – immerse yourself in the latest coding rhythms, updates, and collaborative energy! 🤖✨',
    'Learn the basics of building mobile apps with Flutter.',
    'Create your own video games using the Unity engine.',
    'Compete with other developers to build innovative solutions.',
    'Master the design thinking process for problem-solving.',
    'Develop your confidence and public speaking skills.',
  ];

  final List<String> eventDates = [
    '2024-02-26',
    '2024-04-23',
    '2024-06-10',
    '2024-06-15',
    '2024-06-20',
    '2024-06-27',
  ];

  final List<String> eventTimes = [
    '2:00 PM',
    '5:27 AM',
    '11:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
  ];

  // Combine dates and times into a list of DateTime objects
  final List<DateTime> eventDateTimes = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < eventDates.length; i++) {
      try {
        DateTime eventDateTime = DateFormat('yyyy-MM-dd hh:mm a')
            .parse('${eventDates[i]} ${eventTimes[i]}');
        if (eventDateTime.isAfter(DateTime.now())) {
          eventDateTimes.add(eventDateTime);
        }
      } catch (e) {
        print("Error parsing date/time: ${eventDates[i]} ${eventTimes[i]}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E7251),
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(), // Add spacing to push logo to the right
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/gthr_LogoALT.png', // Replace with your logo image path
                ),
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
            color: Colors.white), // Set back button color to white
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                30.0, 20.0, 30.0, 20.0), // Added top margin
            child: SizedBox(
              width: double.infinity,
              height: 40.0, // Reduced height of the search box
              child: TextField(
                style: TextStyle(
                    fontSize: 14.0), // Adjust font size of the text field
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical:
                      8.0), // Adjust padding of the text field content
                  hintText: 'Search events...',
                  prefixIcon: Icon(Icons.search,
                      size: 20.0), // Adjust size of the search icon
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  print('Searching for events: $value');
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: eventDateTimes.length,
              itemBuilder: (context, index) {
                final eventDateTime = eventDateTimes[index];
                final eventIndex = eventDateTimes.indexOf(eventDateTime);
                return GestureDetector(
                  onTap: () {
                    // Navigate to the redirect page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const EventDetails(),
                      ),
                    );
                  },
                  child: eventCard(
                    context,
                    eventTitles[eventIndex],
                    clubNames[eventIndex],
                    descriptions[eventIndex],
                    eventDateTime,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget eventCard(BuildContext context, String title, String club,
      String description, DateTime eventDateTime) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E7251),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              club,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white70,
                  size: 16.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  DateFormat('EEE, MMM d').format(eventDateTime),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.access_time,
                  color: Colors.white70,
                  size: 16.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  DateFormat('h:mm a').format(eventDateTime),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}