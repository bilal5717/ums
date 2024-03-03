import 'package:flutter/material.dart';

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentPortalPage(),
    );
  }
}

class StudentPortalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Progress'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class Progress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Loop through graph data and display each pie chart
              for (var i = 0; i < graphData.length; i++)
                PieChartCard(graphData[i]['courseName'], graphData[i]['title'], graphData[i]['avgPercentage'], i),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartCard extends StatelessWidget {
  final String courseName;
  final String title;
  final double avgPercentage;
  final int index;

  PieChartCard(this.courseName, this.title, this.avgPercentage, this.index);

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
                courseName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: avgPercentage / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    Text(
                      '${avgPercentage.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sample data for graph
List<Map<String, dynamic>> graphData = [
  {
    'courseName': 'Course 1',
    'title': 'Graph 1',
    'avgPercentage': 75.0,
  },
  {
    'courseName': 'Course 2',
    'title': 'Graph 2',
    'avgPercentage': 90.0,
  },
  // Add more graph data as needed
];
