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

  Future<void> deleteStudent(int studentId) async {
    final url = Uri.parse('http://your-api-url.com/delete_student.php?id=$studentId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _dataDeleted = true;
        });
      } else {
        throw Exception('Failed to delete student');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Student Details'),
      ),
      body: Column(
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
              itemCount: 10, // Replace with actual item count
              itemBuilder: (context, index) {
                // Replace with actual student details
                return ListTile(
                  title: Text('Student Name $index'),
                  subtitle: Text('ID: $index'),
                  leading: CircleAvatar(
                    // Replace with student photo
                    child: Text('Img'),
                  ),
                  onTap: () {
                    // Navigate to student details page
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return StudentDetailsPage(studentId: index.toString()); // Pass the student ID to the details page
                    }));
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          // Navigate to student details page
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return StudentDetailsPage(studentId: index.toString()); // Pass the student ID to the details page
                          }));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          var studentId ;
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return StudentUpdatePage(studentId: studentId.toString(), stId: 0,);
                          }));
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Perform delete operation
                          // Assuming index is the unique identifier for each student
                          // You can replace this with the actual unique identifier
                          int studentId = index;

                          // Call deleteStudent function passing the studentId
                          deleteStudent(studentId);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
