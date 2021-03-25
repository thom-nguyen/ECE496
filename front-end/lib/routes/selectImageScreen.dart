import 'package:flutter/material.dart';
import 'package:foresight/routes/reviewImageScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectImageScreen extends StatelessWidget {
  final picker = ImagePicker();

  void _openCamera(context) async {
    PickedFile _pickedImage = await picker.getImage(
      source: ImageSource.camera,
    );

    if (_pickedImage != null && _pickedImage.path != null) {
      print(_pickedImage.path);
      Navigator.pushNamed(
        context,
        '/reviewImage',
        arguments: SelectImageArguments(_pickedImage.path),
      );
    }
  }

  void _openGallery(context) async {
    PickedFile _pickedImage = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (_pickedImage != null && _pickedImage.path != null) {
      print(_pickedImage.path);
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
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 20.0, 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back arrow
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      iconSize: 60.0,
                      onPressed: () {
                        Navigator.pushNamed(context, '/welcome');
                      },
                    ),
                    // Title name

                    Text(
                      'ForeSight',
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).accentColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                child: Text(
                  'Upload your photo!',
                  style: GoogleFonts.roboto(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Image selection options
              Container(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: ElevatedButton(
                        onPressed: () {
                          _openCamera(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide.none,
                          ),
                          elevation: 10.0,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).backgroundColor,
                          size: 90.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: ElevatedButton(
                        onPressed: () {
                          _openGallery(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide.none,
                          ),
                          elevation: 10.0,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          color: Theme.of(context).backgroundColor,
                          size: 90.0,
                        ),
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
