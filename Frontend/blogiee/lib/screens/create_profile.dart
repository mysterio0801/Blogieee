import 'package:flutter/material.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Name",
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Profession",
                icon: Icon(Icons.admin_panel_settings_rounded),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Date of Birth",
                icon: Icon(Icons.date_range),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
                icon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "About",
              ),
            ),
          ],
        ),
      )
    );
  }
}