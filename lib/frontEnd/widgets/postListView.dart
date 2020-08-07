import 'dart:ui';

import 'package:book_store_app/backend/api/apiBaseHelper.dart';
import 'package:book_store_app/backend/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class PostListView extends StatelessWidget {
  final List<Post> posts;
  var data;
  PostListView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Scaffold(
          body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                constraints: BoxConstraints.expand(
                  height: Theme.of(context).textTheme.display1.fontSize * 1.1 +
                      200.0,
                ),
                color: Colors.white10,
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          contentPadding: EdgeInsets.all(30.0),
                          title: new Text(
                            posts[index].title,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          leading: new Image.network(
                            posts[index].picture,
                            fit: BoxFit.cover,
                            height: 40.0,
                            width: 40.0,
                          ),
                          subtitle: Text(
                            posts[index].catagory,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
