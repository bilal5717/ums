import 'package:flutter/material.dart';
import 'package:ums/Admin/add_result.dart';
import 'package:ums/Admin/view_result.dart';
class StudentResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Result'),
      ),
      body: AllStudentList(),
    );
  }
}

class AllStudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with actual item count
      itemBuilder: (context, index) {
        // Replace with actual student details
        return ListTile(
          title: Text('Student Name $index'),
          subtitle: Text('ID: $index'),
          onTap: () {
            // Navigate to add result page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddResultPage(
                  studentId: index.toString(),
                  studentName: 'Student Name $index',
                ),
              ),
            );
          },
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.add), // Add icon
                onPressed: () {
                  // Navigate to add result page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddResultPage(
                        studentId: index.toString(),
                        studentName: 'Student Name $index',
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.visibility), // View icon
                onPressed: () {
                  // Navigate to view result page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewResultPage(
                        studentId: index.toString(),
                        studentName: 'Student Name $index',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
