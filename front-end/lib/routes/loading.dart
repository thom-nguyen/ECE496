import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEFF3F6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.0,
                width: 150.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF234256)),
                  strokeWidth: 20.0,
                  semanticsLabel: 'Loading AI screening results.',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Loading...',
                  style: GoogleFonts.lato(
                    color: Color(0xFF234256),
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
