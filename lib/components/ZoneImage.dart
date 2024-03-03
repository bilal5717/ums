import 'package:flutter/material.dart';

class ZoneImage extends StatelessWidget {
  final String imagePath;
  final String label;

  ZoneImage(this.imagePath, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        SizedBox(height: 8), // Provides some spacing between the image and text
        Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
