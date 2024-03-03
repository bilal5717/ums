import 'package:flutter/material.dart';
import 'package:ums/student/single_s_cgpa.dart';
class StudentResultPage extends StatefulWidget {
  final String stid;
  final String name;

  const StudentResultPage({required this.stid, required this.name});

  @override
  _StudentResultPageState createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {
  late String semester = '1st';
  late List<Map<String, dynamic>> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Result'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.purple,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Name: ${widget.name}\nStudent ID: ${widget.stid}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: semester,
                  onChanged: (value) {
                    setState(() {
                      semester = value!;
                    });
                  },
                  items: ['1st', '2nd', '3rd']
                      .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text('$e semester'),
                  ))
                      .toList(),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Fetch results for selected semester
                      _fetchResults(semester);
                    },
                    child: Text('View Result'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to view cgpa & completed course page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CgpaDisplayPage(studentId: '', studentName: '',
                    ),
                  ),
                );
              },
              child: Text('View CGPA & Completed Course'),
            ),
            SizedBox(height: 16.0),
            results.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '$semester Semester Result',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.teal,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Subject')),
                    DataColumn(label: Text('Marks')),
                    DataColumn(label: Text('Grade')),
                    DataColumn(label: Text('Credit hr.')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: results.map<DataRow>((result) {
                    return DataRow(cells: [
                      DataCell(Text(result['sub'])),
                      DataCell(Text(result['marks'])),
                      DataCell(Text(_calculateGrade(result['marks']))),
                      DataCell(Text('${_creditHour(result['sub'])}')),
                      DataCell(Text(_getStatus(result['marks']))),
                    ]);
                  }).toList(),
                ),
              ],
            )
                : SizedBox.shrink(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to profile page
                Navigator.pop(context);
              },
              child: Text('Back to Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchResults(String semester) {
    // Fetch results from API based on semester and widget.stid
    // Example: results = fetchResultsFromAPI(widget.stid, semester);
    // After fetching, update the state to rebuild the UI
    setState(() {
      results = [
        {'sub': 'DBMS', 'marks': '85'},
        {'sub': 'Mathematics', 'marks': '72'},
        {'sub': 'Programming', 'marks': '63'},
        {'sub': 'English', 'marks': '78'},
        {'sub': 'Physics', 'marks': '91'},
        {'sub': 'Chemistry', 'marks': '55'},
        {'sub': 'Psychology', 'marks': '70'},
      ];
    });
  }

  String _calculateGrade(String marks) {
    int mark = int.parse(marks);
    if (mark < 60) return 'F';
    if (mark < 70) return 'D';
    if (mark < 80) return 'C';
    if (mark < 90) return 'B';
    return 'A';
  }

  int _creditHour(String subject) {
    switch (subject) {
      case 'DBMS':
      case 'Programming':
      case 'English':
      case 'Physics':
      case 'Chemistry':
      case 'Psychology':
        return 3;
      case 'DBMS Lab':
      case 'Programming Lab':
        return 1;
      case 'Mathematics':
        return 4;
      default:
        return 0;
    }
  }

  String _getStatus(String marks) {
    int mark = int.parse(marks);
    if (mark < 60) return 'Fail';
    if (mark < 70) return 'Retake';
    return 'Pass';
  }
}
