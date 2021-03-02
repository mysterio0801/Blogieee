import 'dart:ui';
import 'package:flutter/material.dart';

bool _isPasswordVisible = true;

@override
void initState(){
  _isPasswordVisible = false;
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.green[100]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _globalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up with Email!",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 80.0),
                TextFormField(
                  validator: (value)
                  {
                    if(value.isEmpty){
                      return "Username cannot be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (value)
                  {
                    if(value.isEmpty){
                      return "Email cannot be empty";
                    }
                    if(!value.contains('@')){
                      return "Email is invalid";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (value)
                  {
                    if(value.isEmpty){
                      return "Password cannot be empty";
                    }
                    if(value.length < 8){
                      return "Password length cannot be less than 8";
                    }
                    return null;
                  },
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                RaisedButton(
                  onPressed: (){
                    if(_globalkey.currentState.validate()){
                      print("Validated");
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: Text("Sign Up", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
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