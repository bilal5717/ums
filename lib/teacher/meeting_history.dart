import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MeetingHistoryPage extends StatefulWidget {
  @override
  _MeetingHistoryPageState createState() => _MeetingHistoryPageState();
}

class _MeetingHistoryPageState extends State<MeetingHistoryPage> {
  List<Meeting> meetings = [];

  // Function to fetch meeting data from PHP script
  Future<void> fetchMeetings() async {
    final response = await http.get(Uri.parse('http://192.168.1.5/ums_api/teacher/meeting_history.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Meeting> fetchedMeetings = data.map((meeting) => Meeting.fromJson(meeting)).toList();

      setState(() {
        meetings = fetchedMeetings;
      });
    } else {
      throw Exception('Failed to load meetings');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting History'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meeting History',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: meetings.length,
                itemBuilder: (context, index) {
                  Meeting meeting = meetings[index];
                  return MeetingItem(
                    title: meeting.title,
                    description: meeting.description,
                    startTime: meeting.startDateTime,
                    endTime: meeting.endDateTime,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingItem extends StatelessWidget {
  final String title;
  final String description;
  final String startTime;
  final String endTime;

  const MeetingItem({
    Key? key,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: $title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Description: $description'),
            SizedBox(height: 8.0),
            Text('Starting time: $startTime'),
            SizedBox(height: 8.0),
            Text('Ended by: $endTime'),
          ],
        ),
      ),
    );
  }
}

class Meeting {
  final String title;
  final String description;
  final String startDateTime;
  final String endDateTime;

  Meeting({
    required this.title,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      title: json['title'],
      description: json['description'],
      startDateTime: json['startDateTime'],
      endDateTime: json['endDateTime'],
    );
  }
}
