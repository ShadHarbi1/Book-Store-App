import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:book_store_app/backend/controllers/appExceptions.dart';
import 'package:book_store_app/backend/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://192.168.1.5:5000/";

  Future<dynamic> get(String url) async {
    var respnseJson;

    try {
      final response = await http.get(_baseUrl + url);
      respnseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return respnseJson;
  }

  Future<List<Post>> getAllPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    final getPublishedPostUrl = "http://192.168.1.7:5000/post/all";
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

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
