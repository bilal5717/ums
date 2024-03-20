import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ums/Admin/single_student_detail.dart';
import 'package:ums/Admin/single_student_update.dart';

class AllStudentDetails extends StatefulWidget {
  @override
  _AllStudentDetailsState createState() => _AllStudentDetailsState();
}

class _AllStudentDetailsState extends State<AllStudentDetails> {
  TextEditingController searchController = TextEditingController();
  bool _dataDeleted = false; // Flag to track data deletion

  Future<void> deleteStudent(String studentId) async {
    final url = Uri.parse('http://192.168.1.5/ums_api/admin/deleteStudent.php?st_id=$studentId');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          setState(() {
            _dataDeleted = true;
          });
        } else {
          throw Exception('Failed to delete student: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to delete student: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting student: $error');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete student: $error')),
      );
    }
  }



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
        title: Text('All Student Details'),
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
                if (_dataDeleted)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Data deleted successfully',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      final studentId = student['s_id'];
                      final id = student['id'];
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
                                  return StudentDetailsPage(studentId: studentId.toString());
                                }));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return StudentUpdate(studentId: id,);
                                }));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteStudent(studentId.toString());
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
