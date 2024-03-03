import 'package:flutter/material.dart';

class ScheduledMeetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Meeting'),
      ),
      body: MeetingList(),
    );
  }
}

class MeetingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meetings.length,
      itemBuilder: (context, index) {
        final meeting = meetings[index];
        return ListTile(
          title: Text(meeting.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(meeting.description),
              Text('Starts at: ${meeting.startDateTime}'),
              Text('Ends by: ${meeting.endDateTime}'),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              // Implement logic to join meeting
            },
            child: Text('Join'),
          ),
        );
      },
    );
  }
}

// Replace this data with actual data fetched from the server
List<Meeting> meetings = [
  Meeting(
    title: 'Meeting 1',
    description: 'Description for meeting 1',
    startDateTime: '2024-03-03 09:00:00',
    endDateTime: '2024-03-03 10:00:00',
    link: 'https://example.com/meeting1',
  ),
  Meeting(
    title: 'Meeting 2',
    description: 'Description for meeting 2',
    startDateTime: '2024-03-04 10:00:00',
    endDateTime: '2024-03-04 11:00:00',
    link: 'https://example.com/meeting2',
  ),
  // Add more meetings as needed
];

class Meeting {
  final String title;
  final String description;
  final String startDateTime;
  final String endDateTime;
  final String link;

  Meeting({
    required this.title,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
    required this.link,
  });
}
