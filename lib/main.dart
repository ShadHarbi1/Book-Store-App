import 'package:book_store_app/backend/controllers/rootPage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:book_store_app/Screen/addProduct.dart';
import 'package:book_store_app/Screen/catalogPage.dart';
import 'package:book_store_app/Screen/homePage.dart';
import 'package:book_store_app/Screen/accountPage.dart';
import 'package:book_store_app/Screen/loginPage.dart';
import 'package:book_store_app/Screen/signUpPage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: CheckAuth(),
      initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/login': (context) => LoginPage(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/signup': (context) => SignupPage(),
    '/home': (context) => HomePage(),
    '/mainPage':(context) => MyNavHomePage(),
  

      },
     // MappingPage(
      //  auth: Auth(),
    // ),
    );
  }
}

class MyNavHomePage extends StatefulWidget {
 
  @override
  _MyNavHomePageState createState() => _MyNavHomePageState();
}

class _MyNavHomePageState extends State<MyNavHomePage> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  //create all the pages

 final AddProductPage _addProductPage = AddProductPage();//addPage
  final HomePage _homePage = HomePage();//homePage
  final CatalogPage _catalogPage = CatalogPage();//cartPage
  final AccountPage _accountPage = AccountPage();//accountPage


   Widget _showPage= new HomePage();
  Widget _pageChooser(int page){
    switch (page){
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
          child:new Text("no Page Found",
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
            Icon(Icons.add, size: 30),//add_page
            Icon(Icons.list, size: 30),//catalog_page
            Icon(Icons.home, size: 30),//home_page//the opening Page
            Icon(Icons.perm_identity, size: 30),//account_page
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
               _showPage= _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage
          ),
        )
        );

  }
}
