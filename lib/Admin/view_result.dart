import 'package:flutter/material.dart';

class ViewResultPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  const ViewResultPage({required this.studentId, required this.studentName});

  @override
  _ViewResultPageState createState() => _ViewResultPageState();
}

class _ViewResultPageState extends State<ViewResultPage> {
  String _selectedSemester = '1st';
  List<Map<String, dynamic>> _resultList = [];

  void _getResults() {
    // Implement fetching results from the server
    // For demonstration purposes, I'm using dummy data
    setState(() {
      _resultList = [
        {'subject': 'DBMS', 'marks': 85},
        {'subject': 'DBMS Lab', 'marks': 75},
        {'subject': 'Mathematics', 'marks': 80},
        {'subject': 'Programming', 'marks': 90},
        {'subject': 'Programming Lab', 'marks': 85},
        {'subject': 'English', 'marks': 88},
        {'subject': 'Physics', 'marks': 78},
        {'subject': 'Chemistry', 'marks': 82},
        {'subject': 'Psychology', 'marks': 79},
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _getResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Result'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.studentName}\nStudent ID: ${widget.studentId}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text('Select Semester:'),
            DropdownButton<String>(
              value: _selectedSemester,
              onChanged: (newValue) {
                setState(() {
                  _selectedSemester = newValue!;
                });
              },
              items: <String>[
                '1st',
                '2nd',
                '3rd',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement fetching results for the selected semester
                _getResults();
              },
              child: Text('View Result'),
            ),
            SizedBox(height: 20.0),
            if (_resultList.isNotEmpty)
              DataTable(
                columns: [
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Marks')),
                ],
                rows: _resultList
                    .map<DataRow>((result) => DataRow(
                  cells: [
                    DataCell(Text(result['subject'])),
                    DataCell(Text(result['marks'].toString())),
                  ],
                ))
                    .toList(),
              ),
            if (_resultList.isEmpty)
              Text('No results found for the selected semester'),
          ],
        ),
      ),
    );
  }
}
