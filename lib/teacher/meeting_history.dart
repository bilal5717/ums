import 'package:flutter/material.dart';

class MeetingHistoryPage extends StatelessWidget {
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
                itemCount: 5, // Update the itemCount with the actual count
                itemBuilder: (context, index) {
                  // Replace the static data with dynamic data from your database
                  return MeetingItem(
                    title: 'Meeting $index',
                    description: 'Description of meeting $index',
                    startTime: 'Start time of meeting $index',
                    endTime: 'End time of meeting $index',
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
