import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_store_app/Screen/loginPage.dart';
import 'package:book_store_app/main.dart';
class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => new _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isLoggedIn;
  @override
  void initState() {
    isLoggedIn = false;
    FirebaseAuth.instance.currentUser().then((user) => user != null
        ? setState(() {
            isLoggedIn = true;
          })
        : null);
    super.initState();
    // new Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? new MyNavHomePage() : new LoginPage();
  }
}