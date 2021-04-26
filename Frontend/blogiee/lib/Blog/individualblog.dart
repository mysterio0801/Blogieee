import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/models/addBlogModels.dart';
import 'package:blogiee/screens/landing_page.dart';
import 'package:blogiee/screens/main_profile.dart';
import 'package:flutter/material.dart';

class IndividualBlog extends StatelessWidget {
  const IndividualBlog({Key key, this.addBlogModel, this.networkHandler}) : super(key: key);
  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogiee"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.delete), 
            onPressed: () {
              networkHandler.delete("/blogPost/delete/${addBlogModel.id}");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingPage()), (route) => false);
            }
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 8,
                child: Column(
                  children: [
                    Container(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: networkHandler.getImage(addBlogModel.id), fit: BoxFit.fill, alignment: AlignmentDirectional.topCenter),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: Text(addBlogModel.title,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 10.0),
                          Text(addBlogModel.comment.toString(),
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 80.0),
                          Icon(
                            Icons.thumb_up,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 10.0),
                          Text(addBlogModel.like.toString(),
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 80.0),
                          Icon(
                            Icons.share,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 10.0),
                          Text(addBlogModel.share.toString(),
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: addBlogModel.body != null ? Text(addBlogModel.body, style: TextStyle(fontSize: 16.0),) : Text("No Body Found", style: TextStyle(fontSize: 16.0),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
