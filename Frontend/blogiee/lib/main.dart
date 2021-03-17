import 'package:blogiee/screens/homepage.dart';
import 'package:blogiee/screens/welcome_screen.dart';
import 'package:blogiee/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();
  Widget page = WelcomeSceen();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String token = await storage.read(key: "token");
    print(token);
    if(token != null){
      setState(() {
        page = HomePage();
      });
    }
    else{
      setState(() {
        page = WelcomeSceen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
       home: page,
    );
  }
}