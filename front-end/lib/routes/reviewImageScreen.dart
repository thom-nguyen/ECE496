import 'dart:io';
import 'package:flutter/material.dart';

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
        color: Color(0xFFEFF3F6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350.0,
                height: 500.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image: FileImage(File(args.pickedImagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 100.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(180.0),
                        side: BorderSide.none,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Color(0xFFEFF3F6),
                        size: 70.0,
                      ),
                      color: Color(0xFF234256),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 100.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loading');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(180.0),
                        side: BorderSide.none,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: Color(0xFFEFF3F6),
                        size: 60.0,
                      ),
                      color: Color(0xFF234256),
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
