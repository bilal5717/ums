import 'package:flutter/material.dart';

class UploadedChartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded Charts'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPLOADED CHARTS',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                // Render batch folders
                for (var i = 0; i < batches.length; i++)
                  BatchCard(batch: batches[i]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BatchCard extends StatelessWidget {
  final String batch;

  BatchCard({required this.batch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event, navigate to the respective group page
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: [
            Icon(Icons.folder, size: 70.0, color: Colors.orange),
            SizedBox(height: 10.0),
            Text(
              batch,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Mock data
List<String> batches = ['Batch 1', 'Batch 2', 'Batch 3']; // Replace with actual batch data

