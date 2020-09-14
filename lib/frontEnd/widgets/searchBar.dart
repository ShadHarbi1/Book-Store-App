import 'dart:ui';
import '';
import 'package:book_store_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 220, horizontal: 65),
            decoration: BoxDecoration(
              color: CustomColors.customPage,
              borderRadius: BorderRadius.circular(29.5),
            ),
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
                hintText: "بحث",
                hintStyle: GoogleFonts.tajawal(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
