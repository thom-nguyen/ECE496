import 'package:flutter/material.dart';

import 'routes/welcome.dart';
import 'routes/selectImage.dart';
import 'package:foresight/routes/reviewImage.dart';
import 'routes/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/selectImage', routes: {
      '/': (context) => WelcomeScreen(),
      '/selectImage': (context) => SelectImageScreen(),
      '/reviewImage': (context) => ReviewImageScreen(),
      '/loading': (context) => LoadingScreen(),
    });
  }
}
