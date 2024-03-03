import 'package:flutter/material.dart';
import 'package:ums/student/S_dashboard.dart';
import 'package:ums/student/single_student_result.dart';
import 'package:ums/student/change_password.dart';

import 'package:ums/components/acadmic_calander.dart';
import '../student/FeesSummary.dart';
import 'package:ums/student/uploads.dart';
import 'package:ums/student/history.dart';
import 'package:ums/student/charts.dart';
import 'package:ums/Login/login.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      backgroundColor: Colors.black54,
      child: ListView(
        shrinkWrap: true,
        children: [
          DrawerListTile(
            icon: Icons.dashboard,
            title: "Dashboard",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  MainScreen();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.grade_sharp,
            title: "Results",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  StudentResultPage(stid: '', name: '',);
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.folder,
            title: "Fee summary",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  FeePage();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.calendar_month,
            title: "Academic Calander",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  Calendar();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.chat,
            title: "Message",
            onTap: () {
            /*  Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  Calendar();
              }));*/
            },
          ),
          DrawerListTile(
            icon: Icons.note,
            title: "Quiz And assignments markssheet",
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  MarksheetPage();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.assignment,
            title: "Assignments deadline",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  MeetingHistoryApp();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.bar_chart,
            title: "Charts",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  Charts();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.password,
            title: "Change Password",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  ChangePasswordPage();
              }));
            },
          ),
          DrawerListTile(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  LoginPage();
              }));
            },
          ),

          const SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }
}



class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}