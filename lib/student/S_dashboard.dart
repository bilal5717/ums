import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ums/components/side_menu.dart';
import 'package:ums/Models/courses.dart';
import 'package:ums/student/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatefulWidget {
  final String email;

  MainScreen({Key? key, required this.email}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String studentName = ''; // Initialize with an empty string
  late String studentId = '';
  final List<Course> courses = [
    Course(1, "CS101", "Introduction to Programming", "BSIT8", "Mr. Parwaiz", 0.90),
    Course(2, "MA102", "Discrete Mathematics", "BSIT8", "Ms. Jane", 0.95),
    Course(3, "CS103", "Data Structures", "BSIT8", "Mr. John", 0.88),
    // Add more courses as needed
  ];

  late double cgpa = 3.75;

  @override
  void initState() {
    super.initState();
    fetchStudentInfo();
  }

  Future<void> fetchStudentInfo() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1/ums_api/student/fetch_profile_data.php?email=${widget.email}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          studentName = data['name'];
          studentId = data['id'];
        });
      } else {
        throw Exception('Failed to load student info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const tableMinWidth = 800.0; // Adjust based on your content needs

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black45,
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.grey),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.grey),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, right: 16, bottom: 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return StudentProfilePage(email: widget.email);
                }));
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTh8fHdvbWVufGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
              ),
            ),
          ),
        ],
      ),
      drawer: SideMenu(email: widget.email),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: max(screenWidth, tableMinWidth)),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Course Code')),
                      DataColumn(label: Text('Subjects')),
                      DataColumn(label: Text('Section')),
                      DataColumn(label: Text('Teachers')),
                      DataColumn(label: Text('Attendance')), // Added column for attendance
                    ],
                    rows: courses.map((course) => DataRow(cells: [
                      DataCell(Text(course.id.toString())),
                      DataCell(Text(course.courseCode)),
                      DataCell(Text(course.subjects)),
                      DataCell(Text(course.section)),
                      DataCell(Text(course.teachers)),
                      DataCell(Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: course.attendancePercentage,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text("${(course.attendancePercentage * 100).toStringAsFixed(0)}%"),
                          ),
                        ],
                      )), // Attendance percentage
                    ])).toList(),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              SingleChildScrollView(
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
              // Other widgets as needed...
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
