import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProfilePage extends StatefulWidget {
  final String sid;

  const UpdateProfilePage({required this.sid});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Your Profile',
              style: TextStyle(
                fontSize: 18,
                backgroundColor: Colors.teal,
                color: Colors.white,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _deptController,
              decoration: InputDecoration(labelText: 'Program'),
            ),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact'),
            ),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() async {
    String name = _nameController.text;
    String dept = _deptController.text;
    String contact = _contactController.text;
    String gender = _genderController.text;
    String address = _addressController.text;

    var data = {
      'sid': widget.sid,
      'name': name,
      'program': dept,
      'contact': contact,
      'gender': gender,
      'address': address,
    };

    var response = await http.post(
      Uri.parse('http://127.0.0.1/ums_api/student/update_profile.php'),
      body: data,
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['success']) {
        _showDialog('Success', 'Profile updated successfully');
      } else {
        _showDialog('Error', responseData['message']);
      }
    } else {
      _showDialog('Error', 'Failed to update profile');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
