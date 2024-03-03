import 'package:flutter/material.dart';

class FileUploadPage extends StatefulWidget {
  final String courseId;
  final String groupId;
  final String classCommittee;

  FileUploadPage({required this.courseId, required this.groupId, required this.classCommittee});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  late List<String> titles;
  late String issue;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    fetchTitles();
    controllers = [];
    issue = '';
  }

  void fetchTitles() {
    // Simulating fetching titles from the server
    titles = ['Title 1', 'Title 2', 'Title 3']; // Replace this with your actual titles
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < titles.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[i],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: controllers.length > i ? controllers[i] : TextEditingController(),
                    decoration: InputDecoration(
                      hintText: 'Select file',
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.0),
            Text(
              'Issue',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) {
                issue = value;
              },
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter any issue',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                uploadFiles();
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  void uploadFiles() {
    // Implement file upload logic here
    for (int i = 0; i < titles.length; i++) {
      // Use controllers[i].text to get the file path
      // Use issue to get the issue description
    }
    // Show alert or perform navigation after upload
  }
}

void main() {
  runApp(MaterialApp(
    home: FileUploadPage(courseId: 'YOUR_COURSE_ID', groupId: 'YOUR_GROUP_ID', classCommittee: 'YOUR_CLASS_COMMITTEE'),
  ));
}
