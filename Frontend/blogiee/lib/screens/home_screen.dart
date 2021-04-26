import 'package:blogiee/Blog/blogs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text("Daily Read",
                  style: GoogleFonts.montserrat(
                    fontSize: 21,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            height: 2.0,
            indent: 5.0,
            endIndent: 5.0,
          ),
          Blogs(
            url: "/blogPost/getOtherResult",
          ),
        ]
    );
  }
}