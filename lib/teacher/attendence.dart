import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentAttendance extends StatefulWidget {
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  String? _selectedSemester;
  String? _selectedSubject;
  TextEditingController searchController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  List<int> _semesters = [1, 2, 3, 4];
  List<String> _subjects = ['Mathematics', 'Physics', 'Chemistry', 'Biology'];

  List<Map<String, dynamic>> _students = [];

  Future<List<Map<String, dynamic>>> fetchStudents() async {
    final url = Uri.parse('http://127.0.0.1/ums_api/teacher/fetchStudentsForatten.php');
    try {
      final response = await http.post(url, body: {
        'semester': _selectedSemester ?? '',
        'subject': _selectedSubject ?? '',
      });
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

  Future<void> takeAttendance() async {
    try {
      await sendAttendanceData();
      print('Attendance data sent successfully');
    } catch (error) {
      print('Failed to send attendance data: $error');
    }
  }

  Future<void> sendAttendanceData() async {
    // Prepare attendance data
    List<Map<String, dynamic>> attendanceData = _students.map((student) {
      return {
        'name': student['name'],
        'status': student['attendance'],
        'date': _selectedDate.toString(),
        'time': _selectedTime.toString(),
      };
    }).toList();

    // Send attendance data to the server
    final url = Uri.parse('http://127.0.0.1/ums_api/teacher/attendence.php');
    print(url);
    final response = await http.post(
      url,
      body: {
        'semester': _selectedSemester,
        'subject': _selectedSubject,
        'attendance': jsonEncode(attendanceData),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send attendance data: ${response.body}');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Take Attendence'),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              DropdownButton<String>(
                value: _selectedSemester,
                hint: Text('Select Semester'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSemester = newValue;
                  });
                },
                items: _semesters.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedSubject,
                hint: Text('Select Subject'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSubject = newValue;
                  });
                },
                items: _subjects.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 10),

            ],
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                _students = await fetchStudents();
                setState(() {});
              },
              child: Text('Fetch Students'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Select Date'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text('Select Time'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                await takeAttendance();
              },
              child: Text('Take Attendance'),
            ),
          ],
        ),
        Flexible(
          child: ListView.builder(
            itemCount: _students.length,
            itemBuilder: (context, index) {
              final student = _students[index];
              final studentId = student['s_id'];
              final studentName = student['name'];
              return ListTile(
                title: Text(studentName ?? ''),
                subtitle: Text('ID: $studentId'),
                leading: CircleAvatar(
                  child: Text('Img'),
                ),
                trailing: DropdownButton<String>(
                  value: student['attendance'],
                  onChanged: (String? value) {
                    setState(() {
                      _students[index]['attendance'] = value;
                    });
                  },
                  items: ['Present', 'Leave', 'Absent'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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

