import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatelessWidget {
  final String email;

  const ChangePasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    void _changePassword(String email, String newPassword, String confirmPassword) async {

      final response = await http.post(
        Uri.parse('http://127.0.0.1/ums_api/teacher/change_password.php'),
        body: {
          'email' : email ,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        try {
          var data = json.decode(response.body);
          if (data['success']) {
            // Password updated successfully
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password updated successfully')),
            );
            // Clear text fields
            _newPasswordController.clear();
            _confirmPasswordController.clear();
          } else {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['error'])),
            );
          }
        } catch (e) {
          print('Error parsing JSON response: $e');
        }
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update password')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform password change operation
                          String newPassword = _newPasswordController.text;
                          String confirmPassword = _confirmPasswordController.text;

                          _changePassword(email, newPassword, confirmPassword);
                        }
                      },
                      child: Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
