import 'package:flutter/material.dart';
import 'all_student_details.dart';
import 'package:ums/Admin/admin_dashboard.dart';
import 'package:ums/Admin/st_result.dart';
import 'package:ums/Admin/s_register.dart';
class Sregister extends StatefulWidget {
  @override
  _AdminZoneState createState() => _AdminZoneState();
}

class _AdminZoneState extends State<Sregister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: () {
               Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          backgroundColor: Color(0xFF4BE0DB),
          centerTitle: true,
          title: Text(
            'Student Management',
            style: TextStyle(fontSize: 20),
          ),
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
                          return StudentRegister();
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
                              'Register new student',
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
                          return AllStudentDetails();
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
                              'All Register Students',
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
                          return AllStudentResults();
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
                              'Results',
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
