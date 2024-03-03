import 'package:flutter/material.dart';

class AddResultPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  const AddResultPage({required this.studentId, required this.studentName});

  @override
  _AddResultPageState createState() => _AddResultPageState();
}

class _AddResultPageState extends State<AddResultPage> {
  String _selectedSubject = 'DBMS';
  String _selectedSemester = '1st';
  TextEditingController _marksController = TextEditingController();

  void _submitMarks() {
    // Implement submitting marks functionality
    String subject = _selectedSubject;
    String semester = _selectedSemester;
    String marks = _marksController.text;

    // You can add validation here before submitting

    // After validation, you can send the data to the server or perform any other action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Result'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.studentName}\nStudent ID: ${widget.studentId}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text('Select Subject:'),
            DropdownButton<String>(
              value: _selectedSubject,
              onChanged: (newValue) {
                setState(() {
                  _selectedSubject = newValue!;
                });
              },
              items: <String>[
                'DBMS',
                'DBMS Lab',
                'Mathematics',
                'Programming',
                'Programming Lab',
                'English',
                'Physics',
                'Chemistry',
                'Psychology',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10.0),
            Text('Select Semester:'),
            DropdownButton<String>(
              value: _selectedSemester,
              onChanged: (newValue) {
                setState(() {
                  _selectedSemester = newValue!;
                });
              },
              items: <String>[
                '1st',
                '2nd',
                '3rd',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _marksController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Marks',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submitMarks,
                  child: Text('Add Marks'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _marksController.clear();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
