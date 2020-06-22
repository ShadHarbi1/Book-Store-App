
import 'package:book_store_app/Screen/rootPage.dart';

import 'package:book_store_app/backend/controllers/authentication.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootPage(auth : Auth()),
    );}}