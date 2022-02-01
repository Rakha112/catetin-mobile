import 'dart:convert';

import 'package:http/http.dart' as http;

class PostSignup {
  int alert;
  String message;

  PostSignup({required this.alert, required this.message});

  factory PostSignup.createPostSignup(Map<String, dynamic> object) {
    return PostSignup(alert: object["alert"], message: object["message"]);
  }

  static Future<PostSignup> connectToAPI(
      String username, String password) async {
    String url = "https://catetinnote.herokuapp.com/signup";
    var apiResult = await http.post(Uri.parse(url),
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return PostSignup.createPostSignup(jsonObject);
  }
}
