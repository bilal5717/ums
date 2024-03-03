import 'package:flutter/material.dart';
import 'package:ums/Admin/single_student_update.dart';
class StudentDetailsPage extends StatelessWidget {
  final String studentId;

  const StudentDetailsPage({Key? key, required this.studentId}) : super(key: key);

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
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white,
                    backgroundImage: studentDetails['img'] != null
                        ? NetworkImage('http://your-domain.com/img/student/${studentDetails['img']}')
                        : AssetImage('assets/default.png') as ImageProvider,
                  ),
                  SizedBox(height: 20.0),
                  Table(
                    columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                    children: [
                      _buildTableRow('Student ID:', studentDetails['st_id']),
                      _buildTableRow('Name:', studentDetails['name']),
                      _buildTableRow('E-mail:', studentDetails['email']),
                      _buildTableRow('Birthday:', studentDetails['bday']),
                      _buildTableRow('Program:', studentDetails['program']),
                      _buildTableRow('Contact:', studentDetails['contact']),
                      _buildTableRow('Gender:', studentDetails['gender']),
                      _buildTableRow('Address:', studentDetails['address']),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to student edit page
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

  Future<Map<String, dynamic>> _fetchStudentDetails(String studentId) async {
    // Replace with your API call to fetch student details by ID
    // Example:
    // final response = await http.get('http://your-domain.com/get_student_details.php?id=$studentId');
    // final jsonData = json.decode(response.body);
    // return jsonData;

    // For demonstration purposes, returning dummy data
    return {
      'name': 'John Doe',
      'img': null,
      'st_id': '123456',
      'email': 'john@example.com',
      'bday': '1990-01-01',
      'program': 'Computer Science',
      'contact': '1234567890',
      'gender': 'Male',
      'address': '123 Main St, City'
    };
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
