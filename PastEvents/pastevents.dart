import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastEvents extends StatefulWidget {
  const PastEvents({Key? key}) : super(key: key);

  @override
  _PastEventsState createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  // Define lists for event data
  final List<String> eventTitles = [
    'Cloud Computing Workshop',
    'AI Ethics Forum',
    'Data Science Expedition',
    'Internet of Things (IoT) Summit: Connecting the World',
    'Cybersecurity Symposium',
  ];

  final List<String> clubNames = [
    'JDSAAP',
    'JPCS',
    'ACM',
    'MCUBE',
    'PubSpeak',
  ];

  final List<String> descriptions = [
    'Master cloud architecture and deployment.',
    'Explore ethical AI considerations.',
    'Uncover insights from big data.',
    'Connect the world with IoT.',
    'Protect the digital frontier.',
  ];

  // Lists for dates and times (replace with your actual data)
  final List<String> eventDates = [
    '2024-05-12',
    '2024-02-22',
    '2024-03-09',
    '2024-01-17',
    '2024-06-26',
  ];

  final List<String> eventTimes = [
    '8:00 AM',
    '10:30 AM',
    '4:00 PM',
    '3:00 PM',
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
        eventDateTimes.add(eventDateTime);
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
              'Past Events',
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
                    // Navigate to a new screen or show a dialog with full details
                    _showEventDetails(
                      context,
                      eventTitles[eventIndex],
                      clubNames[eventIndex],
                      descriptions[eventIndex],
                      eventDateTime,
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

  void _showEventDetails(BuildContext context, String title, String club,
      String description, DateTime eventDateTime) {
    // You can navigate to a new screen or show a dialog with full details here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Club: $club'),
              SizedBox(height: 8),
              Text('Description: $description'),
              SizedBox(height: 8),
              Text('Date: ${DateFormat('EEE, MMM d').format(eventDateTime)}'),
              Text('Time: ${DateFormat('h:mm a').format(eventDateTime)}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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
