import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class AssignmentQuizUploader extends StatefulWidget {
  @override
  _AssignmentQuizUploaderState createState() => _AssignmentQuizUploaderState();
}

class _AssignmentQuizUploaderState extends State<AssignmentQuizUploader> {
  TextEditingController titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  PlatformFile? _selectedFile; // Use PlatformFile instead of File
  String _message = '';

  Future<void> uploadAssignmentQuiz() async {
    if (_selectedFile == null) {
      // No file selected, handle this case according to your app's requirements
      setState(() {
        _message = 'No file selected.';
      });
      return;
    }

    final url = Uri.parse('http://127.0.0.1/ums_api/teacher/assignment_uploads.php');
    print(url);

    // Read file bytes
    List<int> fileBytes = _selectedFile!.bytes!;

    // Encode file bytes to base64
    String fileData = base64Encode(fileBytes);

    final response = await http.post(
      url,
      body: {
        'title': titleController.text,
        'deadline': '${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}',
        'file_data': fileData, // Sending file data as base64 string
        'file_name': _selectedFile!.name, // Sending file name
      },
    );

    if (response.statusCode == 200) {
      // Upload successful
      setState(() {
        _message = 'Assignment/Quiz uploaded successfully.';
      });
    } else {
      // Upload failed
      setState(() {
        _message = 'Failed to upload assignment/quiz.';
      });
    }
  }

  void resetFields() {
    setState(() {
      titleController.clear();
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
      _selectedFile = null;
      _message = '';
    });
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    } else {
      // User canceled the file picking
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Assignment/Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Deadline:'),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text('${selectedTime.hour}:${selectedTime.minute}'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectFile(),
              child: Text('Choose File/Image'),
            ),
            SizedBox(height: 20),
            _selectedFile != null
                ? Text('Selected File: ${_selectedFile!.name}')
                : SizedBox(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await uploadAssignmentQuiz();
              },
              child: Text('Upload'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetFields,
              child: Text('Reset'),
            ),
            SizedBox(height: 20),
            _message.isNotEmpty
                ? Text(_message)
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
