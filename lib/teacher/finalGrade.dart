import 'package:flutter/material.dart';

class GradesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRADES'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GRADES',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(child: Text('O')),
                          TableCell(child: Text('A+')),
                          TableCell(child: Text('A')),
                          TableCell(child: Text('B+')),
                          TableCell(child: Text('B')),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(child: TextFormField(initialValue: '100')),
                          TableCell(child: TextFormField(initialValue: '91')),
                          TableCell(child: TextFormField(initialValue: '80')),
                          TableCell(child: TextFormField(initialValue: '70')),
                          TableCell(child: TextFormField(initialValue: '60')),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(child: Text('C')),
                          TableCell(child: Text('D')),
                          TableCell(child: Text('F')),
                          TableCell(child: Text('FA')),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(child: TextFormField(initialValue: '50')),
                          TableCell(child: TextFormField(initialValue: '40')),
                          TableCell(child: TextFormField(initialValue: '30')),
                          TableCell(child: TextFormField(initialValue: '75')),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Upload tentative grade (xml)',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle file upload
                    },
                    child: Text('Choose File'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    child: Text('Upload'),
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