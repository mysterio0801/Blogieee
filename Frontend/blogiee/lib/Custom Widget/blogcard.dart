import 'dart:io';
import 'package:blogiee/NetworkHandler.dart';
import 'package:blogiee/models/addBlogModels.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key key, this.addBlogModel, this.networkHandler}) : super(key: key);
  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: EdgeInsets.all(10),
      children: [
        Container(
          margin: EdgeInsets.all(15.0),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image : networkHandler.getImage(addBlogModel.id),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addBlogModel.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.0, fontWeight: FontWeight.w500
                    ), 
                    textAlign: TextAlign.start
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(
                      addBlogModel.body != null ? addBlogModel.body : "No Body Found",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0, fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Author : ${addBlogModel.username}",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0, fontWeight: FontWeight.w400
                    ), 
                    textAlign: TextAlign.start
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1.0,
          indent: 5.0,
          endIndent: 5.0,
        ),
      ],
    );
  }
}