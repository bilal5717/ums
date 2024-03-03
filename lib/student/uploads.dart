import 'package:flutter/material.dart';

void main() {
  runApp(MarksheetApp());
}

class MarksheetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marksheet App',
      home: MarksheetPage(),
    );
  }
}

class MarksheetPage extends StatefulWidget {
  @override
  _MarksheetPageState createState() => _MarksheetPageState();
}

class _MarksheetPageState extends State<MarksheetPage> {
  List<Map<String, dynamic>> courses = [
    {'courseId': '1', 'courseName': 'Course 1'},
    {'courseId': '2', 'courseName': 'Course 2'},
    {'courseId': '3', 'courseName': 'Course 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marksheet'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Courses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: courses.map((course) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MarksheetCourseDisplay(
                            courseId: course['courseId'],
                            courseName: course['courseName'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(course['courseName']),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new course functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MarksheetCourseDisplay extends StatelessWidget {
  final String courseId;
  final String courseName;

  const MarksheetCourseDisplay({
    required this.courseId,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: Center(
        child: Text('Marksheet for Course $courseId'),
      ),
    );
  }
}
