import 'package:flutter/material.dart';
import 'uploadfiles.dart';
class File {
  final String classCommittee;
  final String courseId;
  final String groupId;
  final String scheduledDate;

  File({
    required this.classCommittee,
    required this.courseId,
    required this.groupId,
    required this.scheduledDate,
  });
}

class FileListPage extends StatelessWidget {
  final List<File> files;

  FileListPage({required this.files});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Notifications'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            File file = files[index];
            return GestureDetector(
              onTap: () {
                // Navigate to file upload page with parameters
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssignmentQuizUploader(

                    ),
                  ),
                );
              },
              child: Card(
                elevation: 3.0,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Group: ${file.groupId}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Date: ${file.scheduledDate}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Notification: ${file.classCommittee}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  List<File> files = [
    File(classCommittee: 'Notification 1', courseId: 'C1', groupId: 'G1', scheduledDate: '2024-03-10'),
    File(classCommittee: 'Notification 2', courseId: 'C2', groupId: 'G2', scheduledDate: '2024-03-15'),
    // Add more files as needed
  ];

  runApp(MaterialApp(
    home: FileListPage(files: files),
  ));
}
