import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ums/Admin/single_student_update.dart';
import 'package:ums/api_connection/api_connect.dart';


class StudentDetailsPage extends StatelessWidget {
  final String studentId;

  const StudentDetailsPage({Key? key, required this.studentId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchStudentDetails(String studentId) async {
    final url = Uri.parse('http://192.168.1.5/ums_api/admin/view_student_data.php?st_id=$studentId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch student details');
      }
    } catch (error) {
      throw Exception('Failed to fetch student details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: FutureBuilder(
        future: _fetchStudentDetails(studentId),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final studentDetails = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    studentDetails['name'],
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(height: 20.0),
                  Table(
                    columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                    children: [
                      for (var detail in studentDetails.entries)
                        if (detail.key != 'name')
                          _buildTableRow(detail.key, detail.value.toString()),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return StudentUpdate(  studentId: studentDetails['id'],);
                      }));
                    },
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back to student list'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value),
        ),
      ],
    );
  }
}
