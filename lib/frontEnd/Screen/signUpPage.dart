import 'dart:convert';

import 'package:book_store_app/backend/controllers/databaseHelper.dart';
import 'loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_store_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController pwdInputController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  static var url = "http://192.168.1.5:5000/user/register";

  Map data;

  Future register(String name, String email, String password) async {
    Map<String, String> userData = {
      "userName": "$name",
      "userEmail": "$email",
      "userPassword": "$password",
    };

    http.Response response = await http
        .post(url, headers: {"Accept": "application/json"}, body: userData)
        .then((value) {
      if (emailInputController.text.isNotEmpty &&
          pwdInputController.text.isNotEmpty &&
          nameInputController.text.isNotEmpty) {
        if (value.statusCode == 201) {
          print(value.statusCode);
          data = json.decode(value.body);
          print(data);
          DatabaseHelper().save(data["token"]);
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(140, 90, 0.0, 20),
                      child: Text(
                        'مرحبا',
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(120, 70.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nameInputController,
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return 'Invalid name';
                            }

                            return null;
                          },
                          maxLines: 1,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 12),
                              hintText: "اسم المستخدم",
                              hintStyle: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              // hintText: 'EMAIL',
                              // hintStyle: ,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal))),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return 'Invalid email';
                            }

                            return null;
                          },
                          controller: emailInputController,
                          maxLines: 1,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 12),
                              hintText: "البريد الالكتروني",
                              hintStyle: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              // hintText: 'EMAIL',
                              // hintStyle: ,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal))),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: pwdInputController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Password Invalid';
                            }
                            return null;
                          },
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 12),
                              hintText: "كلمة المرور",
                              hintStyle: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal))),
                        ),
                        SizedBox(height: 50.0),
                        Container(
                            height: 40.0,
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.teal,
                                elevation: 7.0,
                                child: GestureDetector(
                                    child: Center(
                                      child: Text(
                                        'التسجيل',
                                        style: GoogleFonts.tajawal(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    onTap: () {
                                      register(
                                          nameInputController.text.trim(),
                                          emailInputController.text.trim(),
                                          pwdInputController.text.trim());
                                    }))),
                        SizedBox(height: 20.0),
                        Text("تملك حساب بالفعل؟"),
                        SizedBox(height: 8.0),
                        Container(
                          height: 40.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/login');
                                },
                                child: Center(
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )),
              // SizedBox(height: 15.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       'New to Spotify?',
              //       style: TextStyle(
              //         fontFamily: 'Montserrat',
              //       ),
              //     ),
              //     SizedBox(width: 5.0),
              //     InkWell(
              //       child: Text('Register',
              //           style: TextStyle(
              //               color: Colors.green,
              //               fontFamily: 'Montserrat',
              //               fontWeight: FontWeight.bold,
              //               decoration: TextDecoration.underline)),
              //     )
              //   ],
              // )
            ]),
      ),
    );
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
}
