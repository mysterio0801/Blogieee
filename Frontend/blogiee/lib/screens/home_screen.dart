import 'package:blogiee/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen'),
            ElevatedButton(
              onPressed: (){
                logout();
              }, 
            child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async{
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeSceen()), (route) => false);    
  }
}