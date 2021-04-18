import 'package:blogiee/Blog/individualblog.dart';
import 'package:blogiee/Custom%20Widget/blogcard.dart';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/models/SuperModel.dart';
import 'package:blogiee/models/addBlogModels.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  Blogs({Key key, this.url}): super(key: key);
  final String url;
  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async{
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0 
      ? Column(
        children: data.map(
          (item) => InkWell(
            child: BlogCard(
              addBlogModel: item, networkHandler: networkHandler
            ), 
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => IndividualBlog()));
            },
          ),
        ).toList(),
      )
      : Center(child: Text("No Blog Found!", style: TextStyle(fontSize: 16.0),));
  }
}