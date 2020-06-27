import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_store_app/main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
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
                        fontSize: 100.0,
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
                key: _loginFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLines: 1,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.right,
                      validator: emailValidator,
                      controller: emailInputController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 12),
                          hintText: "البريد الالكتروني",
                          hintStyle: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal))),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      textAlign: TextAlign.right,
                      controller: pwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 12),
                          hintText: "كلمة المرور",
                          hintStyle: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
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
                            onTap: () {
                              try {
                                if (emailInputController.text.isNotEmpty &&
                                    pwdInputController.text.isNotEmpty) {
                                  showAlertDialog(context);
                                }

                                if (_loginFormKey.currentState.validate()) {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailInputController.text,
                                          password: pwdInputController.text)
                                      .then((authResult) => Firestore.instance
                                              .collection("users")
                                              .document(authResult.user.uid)
                                              .get()
                                              .then((DocumentSnapshot result) =>
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyNavHomePage())))
                                              .catchError((err) {
                                            print(err.message);
                                          }))
                                      .catchError((err) {
                                    print(err.message);
                                  });
                                }
                              } catch (e) {
                                print(e.message);
                              }
                            },
                            child: Center(
                              child: Text(
                                'تسجيل الدخول',
                                style: GoogleFonts.tajawal(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    Text(" لا تملك حساب ؟"),
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
                              Navigator.of(context).pushNamed('/signup');
                            },
                            child: Center(
                              child: Text(
                                'التسجيل',
                                style: GoogleFonts.tajawal(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )),
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
