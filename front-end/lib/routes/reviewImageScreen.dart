import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectImageArguments {
  final String pickedImagePath;

  SelectImageArguments(this.pickedImagePath);
}

class ReviewImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SelectImageArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 20.0, 0.0),
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
                        Navigator.pushNamed(context, '/selectImage');
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

              // Displaying selected image to user
              Container(
                width: 300.0,
                height: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image: FileImage(File(args.pickedImagePath)),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                  border: Border.all(
                      width: 1.5, color: Theme.of(context).primaryColor),
                ),
              ),

              // Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180.0),
                          side: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        elevation: 10.0,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.redoAlt,
                        color: Theme.of(context).primaryColor,
                        size: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loading',
                            arguments:
                                SelectImageArguments(args.pickedImagePath));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180.0),
                          side: BorderSide.none,
                        ),
                        elevation: 10.0,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        color: Theme.of(context).backgroundColor,
                        size: 35.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
