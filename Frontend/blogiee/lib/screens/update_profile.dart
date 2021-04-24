import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/models/profileModel.dart';
import 'package:blogiee/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

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

  NetworkHandler networkHandler = NetworkHandler();
  bool circular = false;
  final _globalKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  PickedFile _image;
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              imageProfile(),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if(value.isEmpty)
                    return "Name can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: profileModel.name,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _professionController,
                validator: (value) {
                  if(value.isEmpty)
                    return "Profession can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Profession",
                  hintText: profileModel.profession,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.admin_panel_settings_rounded),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _dobController,
                validator: (value) {
                  if(value.isEmpty)
                    return "DOB can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "DOB",
                  hintText: profileModel.DOB,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.date_range),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if(value.isEmpty)
                    return "Title can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: profileModel.titleline,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _aboutController,
                validator: (value) {
                  if(value.isEmpty)
                    return "About can't be empty";
                  return null;
                },
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "About",
                  hintText: profileModel.about,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async{
                  circular = true;
                  if(_globalKey.currentState.validate()){
                    Map<String, String> data = {
                      "name" : _nameController.text,
                      "profession" : _professionController.text,
                      "DOB" : _dobController.text,
                      "titleline" : _titleController.text,
                      "about" : _aboutController.text
                    };
                    var response = await networkHandler.patch("/profile/updateProfile", data);
                    print("Validated");
                    print(response.statusCode);
                    if(response.statusCode == 200 || response.statusCode == 201){
                      if(_image.path != null){
                        var imageResponse = await networkHandler.patchImage("/profile/add/image", _image.path);
                        if(imageResponse.statusCode == 200){
                          setState(() {
                            circular = false;
                          });
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
                        }
                      }
                      else{
                        setState(() {
                          circular = false;
                        });
                      }
                    }
                    print(response.body);
                  }
                }, 
                child: circular ? CircularProgressIndicator : Text("Submit"),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                ),
              ),
            ],
          ),
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
              backgroundImage: _image == null ? networkHandler.getImage(profileModel.username) : FileImage(File(_image.path)),
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