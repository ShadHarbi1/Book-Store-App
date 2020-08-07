import 'package:book_store_app/frontEnd/Screen/loginPage.dart';
import 'package:book_store_app/backend/controllers/databaseHelper.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Sign out"),
            onPressed: () {
              DatabaseHelper().save('0');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ),
      ),
    );
  }
}
