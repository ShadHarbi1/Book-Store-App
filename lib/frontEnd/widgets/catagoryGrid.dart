import 'dart:ui';

import 'package:book_store_app/constants/colors.dart';
import 'package:flutter/material.dart';

class Catagory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customDarkBlue,
      body: Stack(
        children: <Widget>[
          GridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                color: CustomColors.customPage,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/clip-reading-a-book.png')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
