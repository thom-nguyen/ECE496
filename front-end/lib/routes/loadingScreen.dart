import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingProgress extends StatefulWidget {
  @override
  _LoadingProgressState createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
  Timer _timer;
  static const timeout = const Duration(seconds: 5);
  static const ms = const Duration(milliseconds: 1);

  void startTimer(int milliseconds) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    _timer = new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    _timer.cancel();
    print('Displaying results');
    Navigator.pushNamed(context, '/results');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTimer(3000);
    return SizedBox(
      height: 150.0,
      width: 150.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF234256)),
        strokeWidth: 20.0,
        semanticsLabel: 'Loading AI screening results.',
      ),
    );
  }
}

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
              LoadingProgress(),
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
