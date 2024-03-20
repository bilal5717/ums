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
                  return StudentProfilePage(sid: studentId, sname: studentName);
                }));
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTh8fHdvbWVufGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
              ),
            ),
          ),
        ],
      ),
      drawer: SideMenu(name: studentName, sid: studentId),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              const Text("My Courses", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          value: cgpa / 4.0,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey[300],
                          color: Theme.of(context).primaryColor,
                        ),
                        Center(
                          child: Text(
                            'CGPA\n$cgpa',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Other widgets as needed...
            ],
          ),
        ),
      ),


    );
  }
}
