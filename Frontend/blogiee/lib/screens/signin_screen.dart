import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/screens/forgot_password.dart';
import 'package:blogiee/screens/landing_page.dart';
import 'package:blogiee/screens/signup_screen.dart';
import 'package:blogiee/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

bool _isPasswordVisible = true;

@override
void initState(){
  _isPasswordVisible = false;
}

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/jake-blucker-tMzCrBkM99Y-unsplash.jpg"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _globalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Welcome Back!",
                      style: GoogleFonts.amaticSc(textStyle: TextStyle(fontSize: 46.0)),
                    ),
                    SizedBox(height: 16),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText("Wanderer",
                          textAlign: TextAlign.center,
                          textStyle: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ], 
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
                SizedBox(height: 80.0),
                Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        errorText: validate ? null : errorText,
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20.0),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordController,
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    errorText: validate ? null: errorText,
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap:  (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.montserrat(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 100.0),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        "New User?",
                        style: GoogleFonts.montserrat(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async{
                    setState(() {
                      circular = true;
                    });
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "password": _passwordController.text
                    };
                    var response = await networkHandler.post("/user/login", data);
                    if(response.statusCode == 200 || response.statusCode == 201){
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output['token']);
                      await storage.write(key: "token", value: output['token']);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingPage()), (route) => false);
                    }
                    else{
                      String output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = output;
                        circular = false;
                      });
                    }
                  },
                  child: circular ? CircularProgressIndicator() : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: Text("Sign In", 
                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.white))
                      ),
                    ),
                  ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}