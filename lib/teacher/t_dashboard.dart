import 'package:flutter/material.dart';
import 'package:ums/teacher/schedule/sidebar.dart';
import 'package:ums/teacher/teacher_profile.dart';
import 'change_password.dart';
import 'package:ums/Login/login.dart';
// Updated Course class to include attendance percentage


class T_dashboard extends StatelessWidget {

  @override
  T_dashboard();
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const tableMinWidth = 800.0; // Adjust based on your content needs

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
                      return ProfilePage();
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
                      return ChangePasswordPage();
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
