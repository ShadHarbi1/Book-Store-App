import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:book_store_app/backend/controllers/appExceptions.dart';
import 'package:book_store_app/backend/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  Future<List<Post>> getAllPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    final getPublishedPostUrl = "http://192.168.1.14:5000/post/all";
    final response = await http.get(getPublishedPostUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((posts) => new Post.fromJson(posts)).toList();
    } else {
      throw "something ";
    }
  }
}
