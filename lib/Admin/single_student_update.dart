import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:ums/api_connection/api_connect.dart';
class StudentUpdate extends StatefulWidget {
  final int studentId;
  const StudentUpdate({Key? key, required this.studentId }) : super(key: key);

  @override
  _StudentUpdateState createState() => _StudentUpdateState();
}

class _StudentUpdateState extends State<StudentUpdate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController programController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File? _selectedImage;
  final _formKey = GlobalKey<FormState>(); // Add form key for validation

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text;
      String email = emailController.text;
      String program = programController.text;
      String contact = contactController.text;
      String gender = genderController.text;
      String address = addressController.text;

      try {
        String uri = 'http://192.168.1.5/ums_api/admin/single_student_update.php';
        print(uri) ;
        var response = await http.post(Uri.parse(uri), body: {
          'st_id': widget.studentId.toString(),
          'st_name': name,
          'st_email': email,
          'st_dept': program,
          'st_contact': contact,
          'st_gender': gender,
          'st_add': address,
        });

        if (response.statusCode == 200) {
          var parsedResponse = jsonDecode(response.body);
          if (parsedResponse['success']) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Profile updated successfully'),
              ),
            );
            // Clear input fields
            nameController.clear();
            emailController.clear();
            programController.clear();
            contactController.clear();
            genderController.clear();
            addressController.clear();
            setState(() {
              _selectedImage = null;
            });
          } else {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update profile'),
              ),
            );
          }
        } else {
          // Handle other HTTP status codes
          print('HTTP Error: ${response.statusCode}');
        }

      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Attach form key to Form widget
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Photo'),
                    _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : Container(),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Choose Photo'),
                    ),

                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Regular expression pattern to validate email syntax
                        RegExp emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: programController,
                      decoration: InputDecoration(labelText: 'Program'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your program';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: contactController,
                      decoration: InputDecoration(labelText: 'Contact'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your contact';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: genderController,
                      decoration: InputDecoration(labelText: 'Gender'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      child: Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
