import 'dart:convert';
import 'package:http/http.dart' as http;

class GetProfile {
  bool loggedIn;
  String username;

  GetProfile({required this.loggedIn, required this.username});

  factory GetProfile.createGetProfile(Map<String, dynamic> object) {
    return GetProfile(
      loggedIn: object["loggedIn"],
      username: object["username"],
    );
  }

  static Future<GetProfile> connectToAPI(String token) async {
    String url = "https://catetinnote.herokuapp.com/profile/mobile";
    var apiResult = await http.post(Uri.parse(url), body: {"token": token});
    var jsonObject = json.decode(apiResult.body.toString());

    return GetProfile.createGetProfile(jsonObject);
  }
}
