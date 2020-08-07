import 'package:flutter/material.dart';
Widget inputField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.amberAccent,
              width: 4,
            )),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }