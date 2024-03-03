import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  final String sid;

  const UpdateProfilePage({required this.sid});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _deptController;
  late TextEditingController _contactController;
  late TextEditingController _genderController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with empty values or fetch from API
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _deptController = TextEditingController();
    _contactController = TextEditingController();
    _genderController = TextEditingController();
    _addressController = TextEditingController();
    // Fetch user data based on sid and populate the controllers
    // Example: getUserData(widget.sid);
  }

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
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
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
              onPressed: () {
                // Perform validation and update profile logic here
                _updateProfile();
              },
              child: Text('Update'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate back to profile page
                Navigator.pop(context);
              },
              child: Text('Back to Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() {
    // Retrieve values from controllers and perform update logic
   /* String name = _nameController.text;
    String email = _emailController.text;
    String dept = _deptController.text;
    String contact = _contactController.text;
    String gender = _genderController.text;
    String address = _addressController.text;*/

    // Call API to update profile with retrieved values
    // Example: updateProfile(widget.sid, name, email, dept, contact, gender, address);

    // After successful update, you might want to show a confirmation message
    // and navigate back to the profile page.
    _showUpdateConfirmation();
  }

  void _showUpdateConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Updated'),
          content: Text('Your profile has been successfully updated.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate back to profile page
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _deptController.dispose();
    _contactController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
