import 'dart:ui';
import 'package:blogiee/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'landing_page.dart';

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
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
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
                  controller: _usernameController,
                  decoration: InputDecoration(
                    errorText: validate ? null : errorText,
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
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
                  controller: _passwordController,
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
                ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      circular = true;
                    });
                    await checkUser();
                    if(_globalkey.currentState.validate() && validate){
                      Map<String, String> data = {
                        "username" : _usernameController.text,
                        "email" : _emailController.text,
                        "password" : _passwordController.text
                      };
                      print(data);
                      var responseRegister = await networkHandler.post("/user/register", data);
                      if(responseRegister.statusCode == 200 || responseRegister.statusCode == 201){
                        Map<String, String> data = {
                          "username" : _usernameController.text,
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Network Error")));
                        }
                      }
                      setState(() {
                        circular = false;
                      });
                    }
                    else{
                      setState(() {
                        circular = false;
                      });
                    }
                  },
                  child: circular ? CircularProgressIndicator() : Padding(
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

  checkUser() async{
    if(_usernameController.text.length == 0){
      setState(() {
        validate = false;
        errorText = "Username can't be empty";
      });
    }
    else{
      var response = await networkHandler.get("/user/checkusername/${_usernameController.text}");
      print(response);
      if(response["Status"]){
        setState(() {
          validate = false;
          errorText = "Username already taken";
        });
      }
      else{
        setState(() {
          validate = true;
        });
      }
    }
  }
}