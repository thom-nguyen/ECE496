import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foresight/routes/reviewImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectImageScreen extends StatelessWidget {
  final picker = ImagePicker();

  void _openGallery(context) async {
    PickedFile _pickedImage = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (_pickedImage != null && _pickedImage.path != null) {
      print(_pickedImage.path);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ReviewImageScreen(pickedImage: _pickedImage),
      //   ),
      // );
      Navigator.pushNamed(
        context,
        '/reviewImage',
        arguments: SelectImageArguments(_pickedImage.path),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEFF3F6),
        child: Center(
          child: Column(
            //Center Column contents vertically,
            mainAxisAlignment: MainAxisAlignment.center,
            //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 0.0,
                  bottom: 40.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF234256),
                      ),
                      iconSize: 60.0,
                      onPressed: () {
                        // TODO: check if context is null
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              // Back arrow
              Container(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Text(
                  'Upload your photo!',
                  style: GoogleFonts.lato(
                    fontSize: 55,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF234256),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 80,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                          minWidth: 150.0,
                          height: 150.0,
                          child: FlatButton(
                            onPressed: () {
                              _openGallery(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide.none,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Color(0xFFEFF3F6),
                              size: 90.0,
                            ),
                            color: Color(0xFF234256),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 150.0,
                          height: 150.0,
                          child: FlatButton(
                            onPressed: () {
                              _openGallery(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide.none,
                            ),
                            child: Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Color(0xFFEFF3F6),
                              size: 90.0,
                            ),
                            color: Color(0xFF234256),
                          ),
                        ),
                      ],
                    ),
                    // Camera and Gallery labels
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 16.0,
                        top: 12.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Camera',
                            style: GoogleFonts.lato(
                              fontSize: 33,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF234256),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Gallery',
                            style: GoogleFonts.lato(
                              fontSize: 33,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF234256),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
