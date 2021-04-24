import 'dart:ui';
import 'package:blogiee/screens/signin_screen.dart';
import 'package:blogiee/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeSceen extends StatefulWidget {
  @override
  _WelcomeSceenState createState() => _WelcomeSceenState();
}


class _WelcomeSceenState extends State<WelcomeSceen> {
  bool _isLogin = false;
  Map data;
  final facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/jake-blucker-tMzCrBkM99Y-unsplash.jpg"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Text("Blogieee",
                      style: GoogleFonts.amaticSc(textStyle: TextStyle(fontSize: 46.0)),
                    ),
                    SizedBox(height: 16),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText("Great Stories for Great People",
                          textAlign: TextAlign.center,
                          textStyle: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ], 
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/3),
              Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: onEmailClick,
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                      child: Icon(Icons.email, color: Colors.white),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                      child: Text('Sign up with Email', style: GoogleFonts.montserrat(fontSize: 16.0, color: Colors.white),),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),),
                      side: MaterialStateProperty.all(BorderSide(color: Colors.blueAccent)),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                      style: GoogleFonts.montserrat(fontSize: 14.0, color: Colors.white),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SigninScreen()));
                        },
                        child: Text("Sign In",
                        style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
    return TextButton(
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