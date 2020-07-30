import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String postUrl = "http://192.168.56.1:4545/feed";
  String authUrl = "http://192.168.56.1:4545/auth";

  var status;

  var token;
  Map data;
  login(String email, String password, String name) async {
    String myUrl = "http://192.168.8.102:4545/auth/login";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "name": "$name",
      "email": "$email",
      "password": "$password"
    }).then((value) {
      if (value.statusCode == 200) {
        data:
        json.decode(value.body);
      } else {
        print("something happened");
      }
    });
  }

  signup(String name, String email, String password) async {
    String myUrl = "$authUrl/signup";
    final response = await http.put(myUrl,
        headers: {'Accept': 'application/json'},
        body: {"name": "$name", "email": "$email", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      save(data["token"]);
    }
  }

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$postUrl/posts";
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
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

  void addData(String name, String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$postUrl/post";
    http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "price": "$price"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
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
