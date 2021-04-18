import 'package:blogiee/Blog/blogs.dart';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/models/profileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: (){
              
            },
            color: Colors.black,
          ),
        ],
      ),
      body: circular ? Center(child: CircularProgressIndicator()) :  ListView(
        children: [
          head(),
          SizedBox(height: 10.0),
          Divider(
            height: 0.8,
          ),
          SizedBox(height: 10.0),
          otherDetails("Name", profileModel.name),
          SizedBox(height: 10.0),
          otherDetails("About", profileModel.about),
          SizedBox(height: 10.0),
          otherDetails("Profession", profileModel.profession),
          SizedBox(height: 10.0),
          otherDetails("DOB", profileModel.DOB),
          SizedBox(height: 10.0),
          Divider(
            height: 0.8,
          ),
          SizedBox(height: 20.0),
          Blogs(url: "/blogPost/getOwnResult"),
        ],
      ),
    );
  }

  Widget head() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: networkHandler.getImage(profileModel.username),
          ),
          SizedBox(height: 10.0),
          Text(
            profileModel.username,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.0),
          Text(
            profileModel.titleline,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5.0),
        Text(
          value,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
        )
      ],
        ),
    );
  }
}