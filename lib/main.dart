import 'package:book_store_app/backend/blocs/auth_bloc.dart';
import 'package:book_store_app/frontEnd/Screen/catalogPage.dart';
import 'package:book_store_app/frontEnd/Screen/accountPage.dart';
import 'package:book_store_app/frontEnd/Screen/addProduct.dart';
import 'package:book_store_app/frontEnd/Screen/homePage.dart';
import 'package:book_store_app/frontEnd/Screen/loginPage.dart';
import 'package:book_store_app/frontEnd/Screen/signupPage.dart';
import 'package:book_store_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (context) => authBloc)],
      child: MaterialApp(
          theme: ThemeData(accentColor: CustomColors.primaryLightWhite),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/login': (context) => LoginPage(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/signup': (context) => SignupPage(),
            '/home': (context) => HomePage(),
            '/mainPage': (context) => MyNavBar(),
          }),
    );
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
}

class MyNavBar extends StatefulWidget {
  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  //create all the pages

  final AddProductPage _addProductPage = AddProductPage(); //addPage
  final HomePage _homePage = HomePage(); //homePage
  final CatalogPage _catalogPage = CatalogPage(); //cartPage
  final AccountPage _accountPage = AccountPage(); //accountPage

  Widget _showPage = new HomePage();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _addProductPage;
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
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add, size: 30), //add_page
            Icon(Icons.list, size: 30), //catalog_page
            Icon(Icons.home, size: 30), //home_page//the opening Page
            Icon(Icons.perm_identity, size: 30), //account_page
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: CustomColors.customDarkBlue,
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
        ));
  }
}
