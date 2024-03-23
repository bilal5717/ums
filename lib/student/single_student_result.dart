import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewResultPage extends StatefulWidget {
  final String email;

  const ViewResultPage({required this.email});

  @override
  _ViewResultPageState createState() => _ViewResultPageState();
}

class _ViewResultPageState extends State<ViewResultPage> {
  String _selectedSemester = '1';
  List<Map<String, dynamic>> _resultList = [];

  double _calculateTotalCGPA() {
    double totalGPA = _resultList
        .map<double>((result) => calculateGPA(result['marks']))
        .reduce((value, element) => value + element);

    return totalGPA / _resultList.length;
  }

  Future<void> _getResults() async {
    try {
      var url = Uri.parse(
          'http://127.0.0.1/ums_api/student/fetch_results.php?email=${widget.email}&semester=$_selectedSemester');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data is List) {
          setState(() {
            _resultList = List<Map<String, dynamic>>.from(data);
          });
        } else if (data is Map && data.containsKey('error')) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(data['error']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(
                'Failed to fetch results. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content:
          Text('An error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String calculateGrade(int marks) {
    if (marks > 85) {
      return 'A';
    } else if (marks > 75) {
      return 'B';
    } else if (marks > 65) {
      return 'C';
    } else if (marks > 50) {
      return 'D';
    } else {
      return 'F';
    }
  }

  double calculateGPA(int marks) {
    if (marks >= 90) {
      return 4.0;
    } else if (marks >= 80) {
      return 3.7;
    } else if (marks >= 70) {
      return 3.3;
    } else if (marks >= 60) {
      return 3.0;
    } else if (marks >= 50) {
      return 2.7;
    } else if (marks >= 45) {
      return 2.3;
    } else if (marks >= 40) {
      return 2.0;
    } else {
      return 0.0;
    }
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
                '1',
                '2',
                '3',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total CGPA: ${_calculateTotalCGPA().toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Marks')),
                      DataColumn(label: Text('Grade')),
                      DataColumn(label: Text('GPA')),
                    ],
                    rows: _resultList
                        .map<DataRow>((result) => DataRow(
                      cells: [
                        DataCell(Text(result['subject'])),
                        DataCell(Text(result['marks'].toString())),
                        DataCell(
                            Text(calculateGrade(result['marks']))),
                        DataCell(Text(calculateGPA(result['marks'])
                            .toString())),
                      ],
                    ))
                        .toList(),
                  ),
                ],
              ),
            if (_resultList.isEmpty)
              Text('No results found for the selected semester'),
          ],
        ),
      ),
    );
  }
}
