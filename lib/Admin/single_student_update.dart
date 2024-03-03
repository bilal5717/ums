import 'dart:io'; // Import the 'File' class

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentUpdatePage extends StatefulWidget {
  final int stId;

  const StudentUpdatePage({Key? key, required this.stId, required String studentId}) : super(key: key);

  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentUpdatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController programController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? _selectedImage;

  Future<void> _updateProfile() async {
    String name = nameController.text;
    String email = emailController.text;
    String program = programController.text;
    String contact = contactController.text;
    String gender = genderController.text;
    String address = addressController.text;

    // Implement your API endpoint for updating the profile
    Uri url = Uri.parse('http://your-api-url.com/update_profile.php');
    var request = http.MultipartRequest('POST', url);
    request.fields['st_id'] = widget.stId.toString();
    request.fields['st_name'] = name;
    request.fields['st_email'] = email;
    request.fields['st_dept'] = program;
    request.fields['st_contact'] = contact;
    request.fields['st_gender'] = gender;
    request.fields['st_add'] = address;

    if (_selectedImage != null) {
      // Add image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'personal_image',
          _selectedImage!,
        ),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      // Handle success
      print('Profile updated successfully');
    } else {
      // Handle error
      print('Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Photo'),
                  _selectedImage != null
                      ? Image.file(File(_selectedImage!))
                      : Container(), // Display selected image
                  ElevatedButton(
                    onPressed: () {
                      // Implement image picker
                    },
                    child: Text('Choose Photo'),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: programController,
                    decoration: InputDecoration(labelText: 'Program'),
                  ),
                  TextField(
                    controller: contactController,
                    decoration: InputDecoration(labelText: 'Contact'),
                  ),
                  TextField(
                    controller: genderController,
                    decoration: InputDecoration(labelText: 'Gender'),
                  ),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
