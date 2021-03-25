import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'routes/welcomeScreen.dart';
import 'routes/disclaimerScreen.dart';
import 'routes/selectImageScreen.dart';
import 'routes/reviewImageScreen.dart';
import 'routes/loadingScreen.dart';
import 'routes/resultsScreen.dart';
import 'routes/errorScreen.dart';

void main() => runApp(new MaterialApp(
      title: 'ForeSight',
      theme: ThemeData(
        primaryColor: Color(0xFF0F366D),
        primaryColorLight: Color(0xFF2B62AE),
        accentColor: Color(0xFF07D2B7),
        backgroundColor: Color(0xFFF8F9FA),
        shadowColor: Color(0xFFAAAAAA),
        hintColor: Color(0xFF343A40),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/welcome': (context) => WelcomeScreen(),
        '/disclaimer': (context) => DisclaimerScreen(),
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
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.only(
          top: 200.0,
        ),
        child: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: WelcomeScreen(),
          image: Image.asset(
            'assets/images/foresight-logo.png',
          ),
          backgroundColor: Theme.of(context).primaryColor,
          photoSize: 160.0,
          loaderColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
