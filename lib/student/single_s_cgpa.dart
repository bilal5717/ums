import 'package:flutter/material.dart';

class CgpaDisplayPage extends StatelessWidget {
  final String studentId;
  final String studentName;

  CgpaDisplayPage({required this.studentId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.purple,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Name: $studentName\nStudent ID: $studentId',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              color: Colors.cyanAccent,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'All Completed Course & Grade',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            FutureBuilder(
              future: fetchData(), // Implement a function to fetch data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Marks')),
                      DataColumn(label: Text('Grade')),
                      DataColumn(label: Text('Credit hr.')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: (snapshot.data as List).map<DataRow>((result) {
                      return DataRow(cells: [
                        DataCell(Text(result['sub'])),
                        DataCell(Text(result['marks'])),
                        DataCell(Text(_calculateGrade(result['marks']))),
                        DataCell(Text('${_creditHour(result['sub'])}')),
                        DataCell(Text(_getStatus(result['marks']))),
                      ]);
                    }).toList(),
                  );
                }
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to another page
              },
              child: Text('Go to result page'),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    // Implement function to fetch data from API or database
    // Replace this with your actual implementation
    return []; // Return a list of maps containing fetched data
  }

  String _calculateGrade(String marks) {
    // Implement grade calculation logic
    return 'Grade'; // Replace this with actual grade calculation
  }

  int _creditHour(String subject) {
    // Implement credit hour calculation logic
    return 0; // Replace this with actual credit hour logic
  }

  String _getStatus(String marks) {
    // Implement status calculation logic
    return 'Status'; // Replace this with actual status calculation
  }
}
