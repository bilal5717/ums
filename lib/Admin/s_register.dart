import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class StudentRegister extends StatefulWidget {
  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentRegister> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController programController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      String s_id = idController.text;
      String name = nameController.text;
      String email = emailController.text;
      String program = programController.text;
      String contact = contactController.text;
      String gender = genderController.text;
      String address = addressController.text;
      String password = passwordController.text;

      try {
        String uri = 'http://127.0.0.1/ums_api/admin/registerStudent.php';
        var request = http.MultipartRequest('POST', Uri.parse(uri));
        request.fields['st_id'] = s_id;
        request.fields['st_name'] = name;
        request.fields['st_email'] = email;
        request.fields['st_dept'] = program;
        request.fields['st_contact'] = contact;
        request.fields['st_gender'] = gender;
        request.fields['st_add'] = address;
        request.fields['password'] = password; // Include password field

        if (_selectedImage != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'personal_image',
              _selectedImage!.path,
            ),
          );
        }

        var response = await request.send();
        var responseData = await response.stream.bytesToString();
        var parsedResponse = jsonDecode(responseData);

        if (parsedResponse['success'] == "true") {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
          // Clear input fields
          idController.clear();
          nameController.clear();
          emailController.clear();
          programController.clear();
          contactController.clear();
          genderController.clear();
          addressController.clear();
          passwordController.clear();
          setState(() {
            _selectedImage = null;
          });
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('register'),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
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
                      controller: idController,
                      decoration: InputDecoration(labelText: 'Student ID'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter student ID';
                        }
                        return null;
                      },
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
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
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
                      child: Text('Register'),
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
