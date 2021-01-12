import 'dart:convert';
import 'package:book_store_app/backend/controllers/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_store_app/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static var url = "http://192.168.1.14:5000/user/login";
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailInputController = TextEditingController();
  final pwdInputController = TextEditingController();
  final nameInputController = TextEditingController();

//first function in the view
  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailInputController.dispose();
    pwdInputController.dispose();
    super.dispose();
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
    if (value != '0') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => MyNavBar()));
    }
  }

  Map data;

  Future logIn(String email, String password) async {
    Map<String, String> userData = {
      //"name": "$name",
      "userEmail": "$email",
      "userPassword": "$password",
    };

    http.Response response = await http
        .post(url, headers: {"Accept": "application/json"}, body: userData)
        .then((value) {
      if (emailInputController.text.isNotEmpty &&
          pwdInputController.text.isNotEmpty) {
        if (value.statusCode == 200) {
          print(value.statusCode);
          data = json.decode(value.body);
          print(data);
          DatabaseHelper().save("token");
          //print("token saved");
          Navigator.pushReplacementNamed(context, "/mainPage");
        } else {
          print("something happened");
          _showDialog(context);
        }
      } else {
        _showDialog(context);
      }

      return value;
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Container()),
    );
  }

  showErrorAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Error has Ocord"),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 5), child: Text("الرجاء الانتظار")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Email format is invalid';
  } else {
    return null;
  }
}

String pwdValidator(String value) {
  if (value.length < 6) {
    return 'Password must be longer than 8 characters';
  } else {
    return null;
  }
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Failed"),
          content: Text("check your email or password"),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            )
          ],
        );
      });
}

void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );
