import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ums/Admin/admin_dashboard.dart';

import 'package:ums/api_connection/api_connect.dart';

class TRegister extends StatefulWidget {
  @override
  _TRegisterState createState() => _TRegisterState();
}

class _TRegisterState extends State<TRegister> {
  late String firstName, lastName, gender, middleName, mobileNumber, experience,
      address, pincode;

  getFirstName(String fname) {
    this.firstName = fname;
  }

  getMiddleName(String mname) {
    this.middleName = mname;
  }

  getLastName(String lname) {
    this.lastName = lname;
  }

  getAddress(String addr) {
    this.address = addr;
  }

  getPincode(String pin) {
    this.pincode = pin;
  }

  getMobileNumber(String mno) {
    this.mobileNumber = mno;
  }

  getGender(String gen) {
    this.gender = gen;
  }

  getExperience(String exp) {
    this.experience = exp;
  }

  createData() async {
    var url = Uri.parse(API.register_teacher);
    var response = await http.post(url, body: {
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'address': address,
      'gender': gender,
      'pincode': pincode,
      'mobile_number': mobileNumber,
      'experience': experience,
    });

    if (response.statusCode == 200) {
      print('Teacher created successfully');
      // Optionally, you can handle further actions here
    } else {
      print('Failed to create teacher: ${response.body}');
    }
  }

  updateData() {
    print('$firstName updated');
    // Implement update functionality if needed
  }

  deleteData() {
    print('$firstName deleted');
    // Implement delete functionality if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          leading: InkWell(
            onTap: () {
             /* Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AdminZone();
              }));*/
            },
            child: Icon(
              Icons.arrow_back,
              size: 50,
            ),
          ),
          backgroundColor: Color(0xFF4BE0DB),
          centerTitle: true,
          title: Text(
            'TEACHER DATA',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getFirstName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Middle Name',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getMiddleName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getLastName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pincode',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getPincode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getMobileNumber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getGender,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Experience',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent, width: 2.0)),
                ),
                onChanged: getExperience,
              ),
            ),

            // Add other TextFormField widgets for other fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: createData,
                  child: Text('Create'),
                ),
                ElevatedButton(
                  onPressed: updateData,
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: deleteData,
                  child: Text('Delete'),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
