import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ums/Admin/single_student_detail.dart';
import 'view_result.dart';

import 'package:ums/api_connection/api_connect.dart';
import 'add_result.dart';

class AllStudentResults extends StatefulWidget {
  @override
  _AllStudentDetailsState createState() => _AllStudentDetailsState();
}

class _AllStudentDetailsState extends State<AllStudentResults> {
  TextEditingController searchController = TextEditingController();


  Future<List<Map<String, dynamic>>> fetchStudents() async {
    final url = Uri.parse('http://127.0.0.1/ums_api/admin/fetchAllStudents.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((student) => student as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to fetch students');
      }
    } catch (error) {
      throw Exception('Failed to fetch students: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Student Results'),
      ),
      body: FutureBuilder(
        future: fetchStudents(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Map<String, dynamic>> students = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search student',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implement search functionality
                        },
                        child: Text('Search'),
                      ),
                    ],
                  ),
                ),


                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      final studentId = student['s_id'];
                      final studentName = student['name'];
                     // final id = student['id'];
                      return ListTile(
                        title: Text(student['name'] ?? ''),
                        subtitle: Text('ID: $studentId'),
                        leading: CircleAvatar(
                          child: Text('Img'),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return StudentDetailsPage(studentId: studentId.toString());
                          }));
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return ViewResultPage(studentId: studentId, studentName: studentName,);
                                }));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return AddResultPage(studentId: studentId, studentName: studentName,);
                                }));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
