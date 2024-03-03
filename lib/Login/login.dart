import 'package:flutter/material.dart';
import 'package:ums/Admin/admin_dashboard.dart';
import 'package:ums/student/S_dashboard.dart';
import 'package:ums/teacher/t_dashboard.dart';
enum UserRole { faculty, student, admin }

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  UserRole _selectedRole = UserRole.faculty; // Default to faculty

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform authentication logic here
      // Example: Make an HTTP request to your server
      print('Username: $_username');
      print('Password: $_password');
      print('Role: $_selectedRole');

      // Route user to appropriate screen based on role
      switch (_selectedRole) {
        case UserRole.faculty:
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return T_dashboard();
          }));
          break;
        case UserRole.student:
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return MainScreen();
          }));
          break;
        case UserRole.admin:
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AdminZone();
          }));
          break;
      }
    }
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
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onChanged: (value) {
                  _username = value;
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
