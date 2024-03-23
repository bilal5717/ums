import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';

class AssignmentFetcher extends StatefulWidget {
  @override
  _AssignmentFetcherState createState() => _AssignmentFetcherState();
}

class _AssignmentFetcherState extends State<AssignmentFetcher> {
  List<Assignment> assignments = [];

  // Function to fetch assignment data from PHP script
  Future<void> fetchAssignments() async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1/ums_api/student/fetch_assignments.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Assignment> fetchedAssignments = data
          .map((assignment) => Assignment.fromJson(assignment))
          .toList();

      setState(() {
        assignments = fetchedAssignments;
      });
    } else {
      throw Exception('Failed to load assignments');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assignments',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  Assignment assignment = assignments[index];
                  return AssignmentItem(
                    title: assignment.title,
                    deadline: assignment.deadline,
                    filedata: assignment.filedata,
                    filename: assignment.filename,
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

class AssignmentItem extends StatelessWidget {
  final String title;
  final String deadline;
  final String filedata;
  final String filename;
  const AssignmentItem({
    Key? key,
    required this.title,
    required this.deadline,
    required this.filedata,
    required this.filename,
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
            Text('Deadline: $deadline'),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                _uploadSolution(context);
              },
              child: Text('Upload Solution'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                _downloadFile(filedata, filename);
              },
              child: Text('Download File'),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadSolution(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        var fileBytes = result.files.single.bytes;
        var fileName = result.files.single.name;

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://127.0.0.1/ums_api/student/upload_solution.php'),
        );

        request.files.add(
          http.MultipartFile.fromBytes(
            'solution',
            fileBytes!,
            filename: fileName,
          ),
        );

        var response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Solution uploaded successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload solution')),
          );
        }
      }
    } catch (e) {
      print('Error uploading solution: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading solution')),
      );
    }
  }

}

class Assignment {
  final String title;
  final String deadline;
  final String filedata;
  final String filename;
  Assignment({
    required this.title,
    required this.deadline,
    required this.filedata,
    required this.filename,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      title: json['title'],
      deadline: json['deadline'],
      filedata: json['filedata'],
      filename: json['filename'],
    );
  }
}

Future<void> _downloadFile(String filedata, String filename) async {
  try {
    // Convert the base64 encoded file data back to bytes
    List<int> bytes = base64Decode(filedata);

    // Create a multipart request to send the file data
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1/ums_api/student/upload_solution.php'), // Replace with your server URL
    );

    // Add the file data to the request
    request.files.add(
      http.MultipartFile.fromBytes(
        'solution', // Name of the file field in the PHP script
        bytes, // File data as bytes
        filename: filedata, // Original filename
      ),
    );

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      print('File uploaded successfully');
      // Optionally, you can show a success message or perform any other action
    } else {
      print('Failed to upload file');
      // Handle the failure, show an error message, etc.
    }
  } catch (e) {
    print('Error downloading file: $e');
    // Handle the error, show an error message, etc.
  }
}

