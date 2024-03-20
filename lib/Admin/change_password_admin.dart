import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordAdmin extends StatefulWidget {
  final String email;

  const ChangePasswordAdmin({required this.email});

  @override
  _ChangePasswordAdminState createState() => _ChangePasswordAdminState();
}

class _ChangePasswordAdminState extends State<ChangePasswordAdmin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final oldPassword = _oldPasswordController.text;
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;

      try {
        var url = Uri.parse('http://192.168.1.5/ums_api/admin/change_password.php');
        print(url);
        print(widget.email);
        var response = await http.post(
          url,
          body: {
            'old_password': oldPassword,
            'new_password': newPassword,
            'confirm_password': confirmPassword,
            'email': widget.email,
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data['success'] != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Password changed successfully'),
              duration: Duration(seconds: 3),
            ));
          } else if (data['error'] != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data['error']),
              duration: Duration(seconds: 3),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to change password. Please try again later.'),
            duration: Duration(seconds: 3),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Color(0xFF1abc9c),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Update Your Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(labelText: 'Old Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _changePassword,
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
