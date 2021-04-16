import 'package:blogiee/Blog/addblog.dart';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/screens/home_screen.dart';
import 'package:blogiee/screens/profile_screen.dart';
import 'package:blogiee/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  NetworkHandler _networkHandler = NetworkHandler();
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  List<String> title = ["Home Page", "My Profile"];
  final storage = new FlutterSecureStorage();
  Widget profilePhoto = CircleAvatar(radius: 65);
  String username = "";

  @override
  void initState(){
    super.initState();
    checkProfile();
  }

  void checkProfile() async{
    var response = await _networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response["username"];
    });
    if(response["status"] == true){
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 65.0,
          backgroundImage: _networkHandler.getImage(response["username"],)
        );
      });
    }
    else{
      setState(() {
        profilePhoto = CircleAvatar(radius: 65);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Row(
                    children: [
                      profilePhoto,
                      SizedBox(width: 15.0),
                      Text("$username", style: TextStyle(fontSize: 16.0),),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('All Post', style: TextStyle(fontSize: 16.0)),
              trailing: Icon(Icons.launch),
              onTap: (){},
            ),
            ListTile(
              title: Text('New Story', style: TextStyle(fontSize: 16.0)),
              trailing: Icon(Icons.add),
              onTap: (){},
            ),
            ListTile(
              title: Text('Settings', style: TextStyle(fontSize: 16.0)),
              trailing: Icon(Icons.settings),
              onTap: (){},
            ),
            ListTile(
              title: Text('Feedback', style: TextStyle(fontSize: 16.0)),
              trailing: Icon(Icons.feedback),
              onTap: (){},
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(fontSize: 16.0)),
              trailing: Icon(Icons.logout),
              onTap: (){
                logout();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(title[currentState]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), 
            onPressed: (){}
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBlog()));
        }, 
        child: Text(
          '+', 
          style: TextStyle(fontSize: 35.0),
        ),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.home),
                color: currentState == 0 ? Colors.white : Colors.white54, 
                onPressed: (){
                  setState(() {
                    currentState = 0;
                  });
                }, 
                iconSize: 35.0),
                IconButton(icon: Icon(Icons.person), 
                color: currentState == 1 ? Colors.white : Colors.white54,
                onPressed: (){
                  setState(() {
                    currentState = 1;
                  });
                },
                iconSize: 35.0),
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }

  void logout() async{
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeSceen()), (route) => false);    
  }
}