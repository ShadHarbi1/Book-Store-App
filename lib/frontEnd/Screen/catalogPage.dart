import 'package:book_store_app/constants/colors.dart';
import 'package:book_store_app/frontEnd/widgets/catagoryGrid.dart';
import 'package:book_store_app/frontEnd/widgets/catagoryScroller.dart';
import 'package:book_store_app/frontEnd/widgets/searchBar.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this will give total height and width of the device
    return Scaffold(
      backgroundColor: CustomColors.customDarkBlue,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * .35,
              width: size
                  .width, //Here the height of the container is 35% of our total height
              decoration: BoxDecoration(
                  color: CustomColors.primaryLightWhite,
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Image.asset(
                  "assets/images/clip-education.png",
                  alignment: Alignment(5.9, 2.0),
                ),
              ),
            ),
            SearchBar(),
          ],
        ),
      ),
    );
  }
}
