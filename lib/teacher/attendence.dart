import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter title',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Batch',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Batch 1'),
                  value: 'batch1',
                ),
                DropdownMenuItem(
                  child: Text('Batch 2'),
                  value: 'batch2',
                ),
              ],
              onChanged: (value) {
                // Handle batch selection
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Group',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Group 1'),
                  value: 'group1',
                ),
                DropdownMenuItem(
                  child: Text('Group 2'),
                  value: 'group2',
                ),
              ],
              onChanged: (value) {
                // Handle group selection
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Course',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Course 1'),
                  value: 'course1',
                ),
                DropdownMenuItem(
                  child: Text('Course 2'),
                  value: 'course2',
                ),
              ],
              onChanged: (value) {
                // Handle course selection
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Upload',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement file upload logic
              },
              child: Text('Choose File'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement upload button logic
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}