import 'package:blogiee/screens/welcome_screen.dart';
import 'package:blogiee/utilities/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
       home: WelcomeSceen(),
    );
  }
}