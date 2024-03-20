import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _getResults() async {
    try {
      var url = Uri.parse('http://127.0.0.1/ums_api/admin/View_result.php?student_id=${widget.studentId}&semester=$_selectedSemester');
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
            content: Text('Failed to fetch results. Please try again later.'),
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
          content: Text('An error occurred. Please try again later.'),
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
