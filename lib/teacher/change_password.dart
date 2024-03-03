import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) => Form(
                      child: Column(
                        children: [
                          TextFormField(
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
                            decoration: InputDecoration(labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your new password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Implement password change functionality
                              final form = Form.of(context);
                              if (form.validate()) {
                                // Form is valid, perform password change operation
                              }
                            },
                            child: Text('Update'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
