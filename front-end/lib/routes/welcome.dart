import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget welcomeText = Column(
    children: [
      // Welcome title
      Container(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Welcome!',
          style: GoogleFonts.lato(
            color: Color(0xFF234256),
            fontSize: 50,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      // Instructions
      Container(
        padding: const EdgeInsets.all(0),
        child: Text(
          Constants.instructionsText,
          softWrap: true,
          style: GoogleFonts.lato(
            color: Color(0xFF234256),
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(0),
        color: Color(0xFFEFF3F6),
        child: Text(
          Constants.stepsText,
          softWrap: true,
          style: GoogleFonts.lato(
            color: Color(0xFF234256),
            fontSize: 19,
            height: 2,
          ),
        ),
      ),
    ],
  );

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEFF3F6),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              welcomeText,
              ButtonTheme(
                minWidth: 350,
                height: 50,
                child: RaisedButton(
                  padding: const EdgeInsets.all(18),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide.none,
                  ),
                  child: Text(
                    'Upload photo for screening',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFEFF3F6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/selectImage');
                    print('Pressed');
                  },
                  color: Color(0xFF234256),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
