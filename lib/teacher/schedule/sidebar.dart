import 'package:flutter/material.dart';
import 'package:ums/teacher/meetings.dart';
import 'package:ums/teacher/meeting_history.dart';
import 'package:ums/teacher/attendence.dart';
import 'package:ums/teacher/uploadfiles.dart';
import 'package:ums/teacher/files.dart';
import 'package:ums/teacher/Charts.dart';
import 'package:ums/teacher/finalGrade.dart';
class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'UMS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.white),
              title: Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to the Dashboard page
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.arrow_circle_up, color: Colors.white),
              title: Text(
                'Meetings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return MeetingForm();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.white),
              title: Text(
                'Meeting History',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return MeetingHistoryPage();
                }));
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.book, color: Colors.white),
              title: Text(
                'Attendence',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return StudentAttendance();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.white),
              title: Text(
                'Assignment/quizes Upload',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return AssignmentQuizUploader();
                }));
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.folder, color: Colors.white),
              title: Text(
                'Files',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FileListPage(files: [],);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart, color: Colors.white),
              title: Text(
                'Charts',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return UploadedChartsPage();
                }));
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.insert_chart, color: Colors.white),
              title: Text(
                'Final Grads',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return GradesPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
