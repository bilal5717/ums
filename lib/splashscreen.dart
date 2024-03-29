import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:ums/Login/login.dart';
//import 'package:ums/Login/login.dart';
import 'package:ums/teacher/t_dashboard.dart';
import 'package:ums/student/S_dashboard.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  super.initState();
  Timer(Duration(seconds: 5), () {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Colors.white,
  body: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  // logo here
  Image.asset(
  'assets/logo.png',
    width: 150,
    height: 150,
  ),
  SizedBox(
  height: 10,
  ),
  Text(
      "Welcome",
       style: TextStyle(fontSize: 40,fontFamily: "calistoga" ,),textAlign: TextAlign.center
  ),
    SizedBox(
      height: 20,
    ),
  CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
  )
  ],
  ),
  ),
  );
  }
  }


