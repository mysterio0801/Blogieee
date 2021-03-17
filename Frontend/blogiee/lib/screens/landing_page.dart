import 'package:blogiee/screens/home_screen.dart';
import 'package:blogiee/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  List<String> title = ["Home Page", "My Profile"];
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
                      CircleAvatar(
                        radius: 65,
                      ),
                      SizedBox(width: 15.0),
                      Text("@username"),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('All Post'),
            )
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
        onPressed: (){}, 
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
}