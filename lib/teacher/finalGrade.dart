import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GradesPage extends StatelessWidget {
  final List<List<String>> gradeData = [
    ['O', 'A+', 'A', 'B+', 'B'],
    ['100', '91', '80', '70', '60'],
    ['C', 'D', 'F', 'FA', ''], // Adjusted to match row length
    ['50', '40', '30', '75', ''], // Adjusted to match row length
  ];

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
            Table(
              border: TableBorder.all(),
              children: gradeData.map((row) {
                return TableRow(
                  children: row.map((cell) {
                    return TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(cell),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Upload tentative grade (xml)',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _selectFile(context),
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
    );
  }

  Future<void> _selectFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle file selection
      PlatformFile file = result.files.first;
      print('File picked: ${file.name}');
    } else {
      // User canceled the file picking
    }
  }
}
