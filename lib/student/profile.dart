import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ums/student/st_profile_update.dart'; // Import http package

class StudentProfilePage extends StatefulWidget {
  final String email;

  const StudentProfilePage({required this.email});

  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  String sname = '';
  String sid = '';
  Map<String, dynamic>? studentData;

  @override
  void initState() {
    super.initState();
    // Fetch student details when the page loads
    fetchStudentDetails();
  }

  // Function to fetch student details
  Future<void> fetchStudentDetails() async {
    try {
      // Make HTTP GET request to the PHP endpoint with email as a query parameter
      final response = await http.get(Uri.parse('http://127.0.0.1/ums_api/student/fetch_profile_data.php?email=${widget.email}'));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);
        // Check if the success key is true
        if (data['success']) {
          // Set sname, sid, and studentData with the fetched data
          setState(() {
            sname = data['sname'];
            sid = data['sid'];
            studentData = data;
          });
        } else {
          // Show error message if the request was not successful
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Show error message if the request failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch student details'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Show error message if an exception occurs
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome: $sname',
                  style: const TextStyle(
                    fontSize: 18,
                    backgroundColor: Colors.teal,
                    color: Colors.white,
                  ),
                ),
                if (sid.isNotEmpty) Text('Student ID: $sid'),
                SizedBox(height: 20),
                if (studentData != null) ...[
                  DataTable(
                    columnSpacing: 20.0,
                    columns: [
                      DataColumn(label: Text('Attribute', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('Email')),
                        DataCell(Text(widget.email)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Contact')),
                        DataCell(Text(studentData!['contact'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Program')),
                        DataCell(Text(studentData!['program'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Gender')),
                        DataCell(Text(studentData!['gender'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Address')),
                        DataCell(Text(studentData!['address'])),
                      ]),
                      // You can add more rows for additional attributes if needed
                    ],
                  ),
                ] else ...[
                  CircularProgressIndicator(), // Show loading indicator while data is being fetched
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(sid: sid,),
                      ),
                    );
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
