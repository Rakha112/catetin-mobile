import 'dart:convert';

import 'package:http/http.dart' as http;

class PostLogin {
  int alert;
  String message;
  String token;
  PostLogin({required this.alert, required this.message, required this.token});

  factory PostLogin.createPostLogin(Map<String, dynamic> object) {
    return PostLogin(
        alert: object["alert"],
        message: object["message"],
        token: object["token"]);
  }

  static Future<PostLogin> connectToAPI(
      String username, String password) async {
    String url = "https://catetinnote.herokuapp.com/login/mobile";
    var apiResult = await http.post(Uri.parse(url),
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return PostLogin.createPostLogin(jsonObject);
  }
}
