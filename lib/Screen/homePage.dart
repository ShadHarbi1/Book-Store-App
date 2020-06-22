import 'package:flutter/material.dart';
import 'package:book_store_app/backend/controllers/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
//later here i will import the models

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
          child: new Text('Logout',
              style: new TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: signOut),
      backgroundColor: Colors.red,
    );
  }
}
