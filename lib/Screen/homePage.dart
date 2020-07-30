import 'package:flutter/material.dart';
//import 'package:test_my_app/backEnd/services/Authentication.dart';
//import 'package:test_my_app/backEnd/services/photoUpload.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.uid}) : super(key: key);
  //update the constructor to include the uid
  final String title;
  final String uid; //include this

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: RaisedButton(onPressed: () {}),
      ),
    );
  }
}
