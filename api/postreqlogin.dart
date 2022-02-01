import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResult {
  int alert;
  String message;

  PostResult({required this.alert, required this.message});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    return PostResult(alert: object["alert"], message: object["message"]);
  }

  static Future<PostResult> connectToAPI(
      String username, String password) async {
    String url = "https://catetinnote.herokuapp.com/login/mobile";
    var apiResult = await http.post(Uri.parse(url),
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);

    return PostResult.createPostResult(jsonObject);
  }
}
