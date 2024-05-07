import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
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
    '2024-02-26'
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
              itemCount: eventDateTimes.length,
              itemBuilder: (context, index) {
                final eventDateTime = eventDateTimes[index];
                final eventIndex = eventDateTimes.indexOf(eventDateTime);
                return eventCard(
                  context,
                  eventTitles[eventIndex],
                  clubNames[eventIndex],
                  descriptions[eventIndex],
                  eventDateTime,
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