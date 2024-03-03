import 'package:flutter/material.dart';
import 'package:ums/student/st_profile_update.dart';
class StudentProfilePage extends StatelessWidget {
  final String sid;
  final String sname;

  const StudentProfilePage({required this.sid, required this.sname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: Center(
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
            // You can add the table here using DataTable or ListTile widgets
            // Example:
            DataTable(
              columns: [
                DataColumn(label: Text('Attribute')),
                DataColumn(label: Text('Value')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Student ID')),
                  DataCell(Text('12345')), // Replace with actual data
                ]),
                DataRow(cells: [
                  DataCell(Text('Name')),
                  DataCell(Text('Rabbaniya')), // Replace with actual data
                ]),
                // Add more rows for other attributes
              ],
            ),
            // Add Update Profile button
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfilePage( sid: '',),
                  ),
                );
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentUpdatePage extends StatelessWidget {
  final String stId;

  const StudentUpdatePage({required this.stId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Center(
        child: Text('Update Profile for Student ID: $stId'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StudentProfilePage(sid: '12345', sname: 'John Doe'),
  ));
}
