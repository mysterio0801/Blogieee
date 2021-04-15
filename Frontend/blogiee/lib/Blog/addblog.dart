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
            child: TextButton(onPressed: null, child: Text('Preview', style: TextStyle(fontSize: 16.0, color: Colors.teal),),),
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
                  onPressed: null, child: Text('Add Blog', style: TextStyle(color: Colors.white),),
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