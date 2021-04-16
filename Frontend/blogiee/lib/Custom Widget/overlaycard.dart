import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OverlayCard extends StatelessWidget {
  const OverlayCard({Key key, this.imageFile, this.title}) : super(key: key);
  final PickedFile imageFile;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image : FileImage(
                  File(imageFile.path),
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            )
          )
        ],
      ),
    );
  }
}