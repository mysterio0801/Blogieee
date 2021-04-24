import 'dart:ui';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/screens/landing_page.dart';
import 'package:blogiee/screens/signin_screen.dart';
import 'package:blogiee/screens/signup_screen.dart';
import 'package:blogiee/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

bool _isPasswordVisible = true;

@override
void initState(){
  _isPasswordVisible = false;
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _globalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/cute-panda-forgot-password-vector-icon-illustration_138676-419.jpg")),
                Text("Oops! Looks like you are lost..",
                  style: GoogleFonts.montserrat(fontSize: 18.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 80.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    errorText: validate ? null : errorText,
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    errorText: validate ? null: errorText,
                    hintText: "New Password",
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async{
                    Map<String, String> data = {
                      "password" : _passwordController.text,
                    };
                    var response = await networkHandler.patch("/user/update/${_usernameController.text}", data);

                    if(response.statusCode == 200 || response.statusCode == 201){
                      print("/user/update/${_usernameController.text}");
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SigninScreen()), (route) => false);
                    }
                  },
                  child: circular ? CircularProgressIndicator() : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: Text("Reset Password", 
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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