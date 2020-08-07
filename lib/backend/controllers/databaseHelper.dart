import 'package:book_store_app/backend/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String postUrl = "http://192.168.56.1:4545/feed";
  String authUrl = "http://192.168.56.1:4545/auth";

  var token;

  Future<Post> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String getAllPostUrl = "http://192.168.1.7:5000/post/all";
    http.Response response = await http.get(getAllPostUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return Post.fromJson(json.decode(response.body));
  }

  void deleteData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$postUrl//post/:postId";
    http.delete(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<Post> addPost(String title, String article, String catagory,
      String picture, String publishedDate) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "";
    final http.Response response = await http.post(
      myUrl,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $value'},
      body: jsonEncode(<String, String>{
        'title': title,
        'article': article,
        'catagory': catagory,
        'picture': picture,
        'publishedDate': publishedDate
      }),
    );
    if (response == 201) {
      return Post.fromJson(json.decode(response.body));
    }
  }

  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
