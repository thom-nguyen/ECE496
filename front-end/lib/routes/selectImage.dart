import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class SelectImageScreen extends StatelessWidget {
  File _image;
  final picker = ImagePicker();

  void _openGallery() async {
    var _image = await picker.getImage(
      source: ImageSource.gallery,
    );
    // print(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: Text('Go back!'),
              onPressed: () {
                // Navigate back to the first screen by popping the current route off the stack.
                Navigator.pop(context);
              },
              color: Color(0xFF234256),
              textColor: Color(0xFFEFF3F6),
            ),
            RaisedButton(
              child: Text('Choose a picture!'),
              onPressed: () {
                _openGallery();
              },
              color: Color(0xFF234256),
              textColor: Color(0xFFEFF3F6),
            ),
            Icon(
              Icons.camera_alt,
              color: Color(0xFF234256),
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
