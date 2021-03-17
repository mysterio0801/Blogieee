import 'dart:ui';
import 'package:blogiee/screens/signin_screen.dart';
import 'package:blogiee/screens/signup_screen.dart';
import 'package:blogiee/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

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
              boxContainer("assets/fb.png", "Sign up with Facebook", onFBLogin),
              boxContainer("assets/icons8-important-mail-96 (4) - Copy.png", "Sign up with Email", onEmailClick),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SigninScreen()));
                    },
                    child: Text("Sign In",
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onFBLogin() async{
    print("is it working");
    final result = await facebookLogin.logIn(['email']);
    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final response = await http.get("https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token");
        final data1 = JSON.jsonDecode(response.body);
        print(data1);
        setState(() {
          _isLogin = true;
          data = data1;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isLogin = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isLogin = false;
        });
        break;
    }
    if(_isLogin){
      print('true');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
    }
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