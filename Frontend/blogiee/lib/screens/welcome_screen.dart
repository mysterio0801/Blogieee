import 'dart:ui';
import 'package:blogiee/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeSceen extends StatefulWidget {
  @override
  _WelcomeSceenState createState() => _WelcomeSceenState();
}

class _WelcomeSceenState extends State<WelcomeSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.green[100]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Blogieee",
                style: TextStyle(
                  fontSize: 38.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/12),
              Text("Great Stories for Great People",
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 40.0),
              boxContainer("assets/google.png", "Sign up with Google", null),
              SizedBox(height: 20.0),
              boxContainer("assets/fb.png", "Sign up with Facebook", null),
              SizedBox(height: 20.0),
              boxContainer("assets/icons8-important-mail-96 (4) - Copy.png", "Sign up with Email", onEmailClick),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                  ),
                  SizedBox(width: 5.0),
                  Text("Sign In",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onEmailClick(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }  

  Widget boxContainer(String path, String text, onClick) {
    return FlatButton(
      onPressed: onClick,
      child: Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width - 140,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(path, height: 40.0,),
              SizedBox(width: 20.0),
              Text(text, 
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}