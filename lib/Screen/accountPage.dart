import 'package:firebase_auth/firebase_auth.dart';
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
            onPressed: (){
              FirebaseAuth.instance.signOut().then((value){
                Navigator.of(context).pushReplacementNamed('/login');
              }).catchError((e){
                print(e);
              });
            }
          ),
        ),
      ),
    );
  }
}