import 'package:flutter/material.dart';

void main() {
  runApp(MeetingHistoryApp());
}

class MeetingHistoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MeetingHistoryPage(),
    );
  }
}

class MeetingHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting History'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meeting History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DataTable(
                columns: [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Starting Time')),
                  DataColumn(label: Text('Ended By')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Meeting 1')),
                    DataCell(Text('Description 1')),
                    DataCell(Text('10:00 AM')),
                    DataCell(Text('User 1')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Meeting 2')),
                    DataCell(Text('Description 2')),
                    DataCell(Text('11:00 AM')),
                    DataCell(Text('User 2')),
                  ]),
                  // Add more rows as needed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
