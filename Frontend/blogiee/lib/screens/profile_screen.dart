import 'package:blogiee/screens/create_profile.dart';
import 'package:blogiee/screens/main_profile.dart';
import 'package:flutter/material.dart';
import 'package:blogiee/NetworkHandler.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NetworkHandler _networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();

  @override
  void initState(){
    super.initState();
    checkProfile();
  }

  void checkProfile() async{
    var response = await _networkHandler.get("/profile/checkProfile");
    if(response["status"] == true){
      setState(() {
        page = MainProfile();
      });
    }
    else{
      setState(() {
        page = button();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: page
      ),
    );
  }

  // Widget profile(){
  //   return Center(
  //     child: Text("Profile Hai")
  //   );
  // }

  Widget button(){
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Tap the button to add profile data",
              style: TextStyle(
                color: Colors.red[300],
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateProfile()));
            },
            label: Text("Add Profile"),
            icon: Icon(Icons.person_add),
          )
        ],
      ),
    );
  }
}