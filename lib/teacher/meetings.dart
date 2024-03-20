import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MeetingForm extends StatefulWidget {
  @override
  _MeetingFormState createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _startDateTimeController = TextEditingController();
  final TextEditingController _endDateTimeController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  Future<void> _submitForm() async {
    final url = 'http:// 192.168.1.5/ums_api/teacher/held_meetings.php'; // Replace with your PHP script URL

    final response = await http.post(
      Uri.parse(url),
      body: {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'semester': _semesterController.text,
        'subject': _subjectController.text,
        'startDateTime': _startDateTimeController.text,
        'endDateTime': _endDateTimeController.text,
        'link': _linkController.text,
      },
    );

    if (response.statusCode == 200) {
      // Meeting details inserted successfully
      print('Meeting details inserted successfully');
    } else {
      // Failed to insert meeting details
      print('Failed to insert meeting details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _semesterController,
              decoration: InputDecoration(labelText: 'Semester'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: _startDateTimeController,
              decoration: InputDecoration(labelText: 'Start Date Time'),
            ),
            TextField(
              controller: _endDateTimeController,
              decoration: InputDecoration(labelText: 'End Date Time'),
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Meeting Link'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
