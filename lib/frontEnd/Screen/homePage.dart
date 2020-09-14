import 'package:book_store_app/backend/api/apiBaseHelper.dart';
import 'package:book_store_app/backend/controllers/databaseHelper.dart';
import 'package:book_store_app/backend/models/post_model.dart';
import 'package:book_store_app/frontEnd/widgets/catagoryScroller.dart';
import 'package:book_store_app/frontEnd/widgets/postListView.dart';
import 'package:book_store_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:test_my_app/backEnd/services/Authentication.dart';
//import 'package:test_my_app/backEnd/services/photoUpload.dart';

class HomePage extends StatefulWidget {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Future<List<Post>> futurePost;
  @override
  void initState() {
    super.initState();
    futurePost = ApiBaseHelper().getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: CustomColors.customDarkBlue,
      body: new Padding(
        padding: EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
        child: FutureBuilder<List<Post>>(
          future: ApiBaseHelper().getAllPosts(),
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? PostListView(posts: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
