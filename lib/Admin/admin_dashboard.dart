import 'package:flutter/material.dart';
import 'package:ums/Admin/s_register.dart';
import 'package:ums/Admin/t_register.dart';
import 'package:ums/Login/login.dart';
import 'package:ums/teacher/change_password.dart';

class AdminZone extends StatefulWidget {
  @override
  _AdminZoneState createState() => _AdminZoneState();
}

class _AdminZoneState extends State<AdminZone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('UMS'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                     /* Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProfilePage();
                      }));*/
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 15.0,
              bottom: 16.0,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Sregister();
                        }));
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/sregister.png",
                              width: 150,
                              height: 150,
                            ),
                          ),

                          Container(
                            child: Text(
                              'Students',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 14,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return TRegister();
                        }));
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/tregister.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Teachers',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
