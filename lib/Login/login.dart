import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ums/Admin/admin_dashboard.dart';
import 'package:ums/student/S_dashboard.dart';
import 'package:ums/teacher/T_dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String _password = '';
  UserRole _selectedRole = UserRole.student;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        var url = Uri.parse('http://192.168.1.5/ums_api/authentication/login.php');
        var response = await http.post(url, body: {
          'email': email,
          'password': _password,
          'role': _selectedRole.toString().split('.').last, // Convert enum value to string
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data['success']) {
            // Navigate to respective dashboard based on role
            switch (_selectedRole) {
              case UserRole.student:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
                break;
              case UserRole.admin:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminZone(email: email,)));
                break;
              case UserRole.teacher:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => T_dashboard()));
                break;
            }
          } else {
            // Show error message
            _showAlertDialog('Login Failed', data['error']);
          }
        } else {
          _showAlertDialog('Error', 'Failed to authenticate');
        }
      } catch (e) {
        print('Error: $e');
        _showAlertDialog('Error', 'An error occurred. Please try again later.');
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum UserRole { student, admin, teacher }

extension UserRoleExtension on UserRole {
  String get stringValue {
    switch (this) {
      case UserRole.student:
        return 'student';
      case UserRole.admin:
        return 'admin';
      case UserRole.teacher:
        return 'teacher';
    }
  }
}
