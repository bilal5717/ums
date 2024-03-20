import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import for date formatting

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

  String _message = '';

  // Function to reset all text controllers and clear message
  void _resetForm() {
    _titleController.clear();
    _descriptionController.clear();
    _semesterController.clear();
    _subjectController.clear();
    _startDateTimeController.clear();
    _endDateTimeController.clear();
    _linkController.clear();
    setState(() {
      _message = '';
    });
  }

  Future<void> _submitForm() async {
    final url = "http://192.168.1.5/ums_api/teacher/held_meetings.php"; // Replace with your PHP script URL

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
      setState(() {
        _message = 'Meeting details inserted successfully';
      });
    } else {
      // Failed to insert meeting details
      setState(() {
        _message = 'Failed to insert meeting details';
      });
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
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _startDateTimeController.text =
                          DateFormat('yyyy-MM-dd').format(picked) +
                              ' ' +
                              pickedTime.format(context);
                    });
                  }
                }
              },
              decoration: InputDecoration(labelText: 'Start Date Time'),
            ),
            TextField(
              controller: _endDateTimeController,
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _endDateTimeController.text =
                          DateFormat('yyyy-MM-dd').format(picked) +
                              ' ' +
                              pickedTime.format(context);
                    });
                  }
                }
              },
              decoration: InputDecoration(labelText: 'End Date Time'),
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Meeting Link'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                _resetForm();
              },
              child: Text('Reset'),
            ),
            SizedBox(height: 20.0),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
