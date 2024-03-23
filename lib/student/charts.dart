import 'package:flutter/material.dart';

class StudentPortalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester Progress'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Semester Progress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Loop through semester data and display progress
              for (var i = 0; i < semesterData.length; i++)
                SemesterProgressCard(semesterData[i]),
            ],
          ),
        ),
      ),
    );
  }
}

class SemesterProgressCard extends StatelessWidget {
  final Map<String, dynamic> semester;

  SemesterProgressCard(this.semester);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Semester: ${semester['semester']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Display semester CGPA
              Text(
                'Semester CGPA: ${semester['cgpa']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              // Display subject-wise details
              for (var subject in semester['subjects'])
                SubjectDetailsCard(subject),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectDetailsCard extends StatelessWidget {
  final Map<String, dynamic> subject;

  SubjectDetailsCard(this.subject);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject: ${subject['name']}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Attendance: ${subject['attendance']}%',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          LinearProgressIndicator(
            value: subject['attendance'] / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 5),
          Text(
            'GPA: ${subject['gpa']}',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          // GPA Circular Progress Indicator
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: subject['gpa'] / 4,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Sample data for semester progress
List<Map<String, dynamic>> semesterData = [
  {
    'semester': 'Semester 1',
    'cgpa': 3.6,
    'subjects': [
      {'name': 'Subject 1', 'attendance': 80, 'gpa': 3.5},
      {'name': 'Subject 2', 'attendance': 75, 'gpa': 4.0},
    ],
  },
  {
    'semester': 'Semester 2',
    'cgpa': 3.8,
    'subjects': [
      {'name': 'Subject 3', 'attendance': 85, 'gpa': 3.7},
      {'name': 'Subject 4', 'attendance': 70, 'gpa': 3.2},
    ],
  },
  // Add more semester data as needed
];
