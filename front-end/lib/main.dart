import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'routes/welcomeScreen.dart';
import 'routes/selectImageScreen.dart';
import 'routes/reviewImageScreen.dart';
import 'routes/loadingScreen.dart';
import 'routes/resultsScreen.dart';
import 'routes/errorScreen.dart';

void main() => runApp(new MaterialApp(
      initialRoute: '/',
      routes: {
        // TODO: Potentially have a screen that shows past results?
        // TODO: Disclaimer screen
        // TODO: UI Improvements
        '/': (context) => Splash(),
        '/welcome': (context) => WelcomeScreen(),
        '/selectImage': (context) => SelectImageScreen(),
        '/reviewImage': (context) => ReviewImageScreen(),
        '/loading': (context) => LoadingScreen(),
        '/results': (context) => ResultsScreen(),
        '/error': (context) => ErrorScreen(),
      },
    ));

class Splash extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  navigateToWelcome() {
    Navigator.pushNamed(context, '/selectImage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF234256),
        padding: const EdgeInsets.only(
          top: 200.0,
        ),
        child: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: WelcomeScreen(),
          image: Image.asset(
            'assets/images/foresight-logo.png',
          ),
          backgroundColor: Color(0xFF234256),
          photoSize: 160.0,
          loaderColor: Color(0xFF234256),
        ),
      ),
    );
  }
}
