import 'dart:ui';
import 'package:book_store_app/backend/api/apiBaseHelper.dart';
import 'package:book_store_app/backend/models/post_model.dart';
import 'package:book_store_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class PostListView extends StatelessWidget {
  final List<Post> posts;
  var data;
  PostListView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.customDarkBlue,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: CustomColors.customPage),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          width: MediaQuery.of(context).size.width - 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                posts[index].title,
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    posts[index].createdAt,
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.tajawal(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    posts[index].catagory,
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.tajawal(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          child: Image.network(
                            posts[index].picture,
                            fit: BoxFit.cover,
                            alignment: Alignment.topLeft,
                            height: 100,
                            width: 120,
                          )),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}

/* ListTile(
  title: new Text(
  posts[index].title,
    textDirection:
    TextDirection.rtl,
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
                                                alignment: Alignment.topLeft,
                                                height: 40.0,
                                                width: 40.0,
                                              ),
                                              subtitle: Text(
                                                posts[index].catagory,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: GoogleFonts.tajawal(
                                                  textStyle: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                              ), */
