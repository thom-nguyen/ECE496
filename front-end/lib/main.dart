import 'package:flutter/material.dart';

import 'routes/welcome.dart';
import 'routes/selectImage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/selectImage', routes: {
      '/': (context) => WelcomeScreen(),
      '/selectImage': (context) => SelectImageScreen(),
    });
  }
}
