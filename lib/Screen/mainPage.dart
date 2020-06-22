import 'package:flutter/material.dart';
import 'package:book_store_app/backend/controllers/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:book_store_app/Screen/accountPage.dart';
import 'package:book_store_app/Screen/addPage.dart';
import 'package:book_store_app/Screen/homePage.dart';
import 'package:book_store_app/Screen/catalogPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//later here i will import the models

class MainPage extends StatefulWidget {
    MainPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  //create all the pages

  final AddPage _addPage = AddPage(); //addPage
  final CatalogPage _catalogPage = CatalogPage();
  final HomePage _homePage = HomePage(); //homePage
  final AccountPage _accountPage = AccountPage(); //accountPage

  Widget _showPage = new HomePage();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _addPage;
        break;
      case 1:
        return _catalogPage;
        break;
      case 2:
        return _homePage;
        break;
      case 3:
        return _accountPage;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              "no Page Found",
              style: new TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 2,
            height: 50.0,
            items: <Widget>[
              Icon(Icons.add, size: 30), //add_page/
              Icon(Icons.list, size: 30), //catalog_page
              Icon(Icons.home,size: 30), //homepage
              Icon(Icons.perm_identity, size: 30), //account_page
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.teal,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (int tappedIndex) {
              setState(() {
                _showPage = _pageChooser(tappedIndex);
              });
            },
          ),
          body: Container(
            color: Colors.blueAccent,
            child: Center(child: _showPage),
          )),
    );
  }
}
