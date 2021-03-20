import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  PickedFile _image;
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            imageProfile(),
            SizedBox(height: 20.0),
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

  Future takePhoto(ImageSource source) async{
    final pickedFile = await _imagePicker.getImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }

  Widget imageProfile(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: _image == null ? AssetImage("assets/cr0Ed4-Y_400x400.jpg") : FileImage(File(_image.path)),
            ),
            Positioned(
              bottom: 30.0,
              right: -10.0,
              child: IconButton(
                iconSize: 30.0,
                color: Colors.teal,
                icon: Icon(Icons.camera_alt),
                onPressed: (){
                  showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(){
    return Container(
      height: 110.0,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: [
            Text("Choose Profile Photo",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 3.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: (){
                        takePhoto(ImageSource.camera);
                    }, 
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                    label: Text("Camera"),
                  ),
                  SizedBox(width: 30.0),
                  TextButton.icon(
                    onPressed: (){
                      takePhoto(ImageSource.gallery);
                    }, 
                    icon: Icon(
                      Icons.photo,
                    ),
                    label: Text("Gallery"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}