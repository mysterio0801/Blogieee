import 'dart:convert';

import 'package:blogiee/Custom%20Widget/overlaycard.dart';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/models/addBlogModels.dart';
import 'package:blogiee/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _globalKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  PickedFile _image;
  final ImagePicker _imagePicker = ImagePicker();
  IconData iconPhoto = Icons.image;
  NetworkHandler _networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.clear), 
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: (){
                if(_image.path != null && _globalKey.currentState.validate()){
                  showModalBottomSheet(
                    context: context, 
                    builder: ((builder) => OverlayCard(imageFile : _image, title: _titleController.text)),
                  );
                }
              },
              child: Text('Preview', style: TextStyle(fontSize: 16.0, color: Colors.teal),),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              titleTextField(),
              bodyTextField(),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton(
                  onPressed: () async{
                    if(_image.path != null && _globalKey.currentState.validate()){
                      AddBlogModel addBlogModel = AddBlogModel(body: _bodyController.text, title: _titleController.text);
                      var response = await _networkHandler.post1("/blogPost/add", addBlogModel.toJson());
                      print(response.body);

                      if(response.statusCode == 200 || response.statusCode == 201){
                        String id = json.decode(response.body)["data"];
                        var imageResponse = await _networkHandler.patchImage("/blogPost/add/coverImage/$id", _image.path);
                        print(imageResponse.statusCode);
                        if(imageResponse.statusCode == 200 || imageResponse.statusCode == 201){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
                        }
                      }
                    }
                  }, 
                  child: Text('Add Blog', style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal), 
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget titleTextField(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: _titleController,
        validator: (value) {
          if(value.isEmpty){
            return "Title can't be empty";
          }
          else if(value.length > 100){
            return "Max Words Limit Reached";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Add Image & Title",
          prefixIcon: IconButton(
            icon: Icon(iconPhoto), 
            onPressed: takeCoverPhoto,
            color: Colors.teal,
          ),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: _bodyController,
         validator: (value) {
          if(value.isEmpty){
            return "Body can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Your Blog",
        ),
        maxLines: null,
      ),
    );
  }

  void takeCoverPhoto() async{
    final coverPhoto = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = coverPhoto;
      iconPhoto = Icons.check_box;
    });
  }
}