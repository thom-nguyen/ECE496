import 'package:flutter/material.dart';

import 'routes/welcome.dart';
import 'routes/selectImage.dart';
import 'routes/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/loading', routes: {
      '/': (context) => WelcomeScreen(),
      '/selectImage': (context) => SelectImageScreen(),
      '/loading': (context) => LoadingScreen(),
    });
  }
}
