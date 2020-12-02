import 'package:flutter/material.dart';

import 'routes/welcomeScreen.dart';
import 'routes/selectImageScreen.dart';
import 'routes/reviewImageScreen.dart';
import 'routes/loadingScreen.dart';
import 'routes/resultsScreen.dart';
import 'routes/errorScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // TODO: Potentially have a screen that shows past results?
        '/': (context) => WelcomeScreen(),
        '/selectImage': (context) => SelectImageScreen(),
        '/reviewImage': (context) => ReviewImageScreen(),
        '/loading': (context) => LoadingScreen(),
        '/results': (context) => ResultsScreen(),
        '/error': (context) => ErrorScreen(),
      },
    );
  }
}
