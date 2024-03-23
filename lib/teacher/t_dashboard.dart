import 'package:flutter/material.dart';
import 'package:ums/teacher/schedule/sidebar.dart';
import 'package:ums/teacher/teacher_profile.dart';
import 'package:ums/student/change_password.dart';
import 'package:ums/Login/login.dart';
// Updated Course class to include attendance percentage


class Tdashboard extends StatefulWidget {
  final String email ;

  const Tdashboard({required this.email});
  @override
  State<Tdashboard> createState() => _T_dashboardState();
}

class _T_dashboardState extends State<Tdashboard> {
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Text('UMS'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ProfilePage(email: '',);
                    }));
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Password'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ChangePasswordPage(email: widget.email,);
                    }));
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Help'),
                  onTap: () {
                    // Handle help tap
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return LoginPage();
                    }));
                  },
                ),
              ),
            ],
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      drawer:  Sidebar(),
      body: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


               SizedBox(height: 20),]
        ),
        ),
    ),
    );
  }
}
