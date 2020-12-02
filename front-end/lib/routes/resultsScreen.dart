import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  Widget welcomeText = Column(
    children: [
      // Confidence Score
      Container(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Confidence Score: ##',
          style: GoogleFonts.lato(
            color: Color(0xFF234256),
            fontSize: 50,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              welcomeText,
              Container(
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          'Upload another photo',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFEFF3F6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/selectImage');
                        },
                        color: Color(0xFF234256),
                      ),
                    ),
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
                          'Return to home page',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFEFF3F6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        color: Color(0xFF234256),
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
