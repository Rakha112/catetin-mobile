import 'dart:convert';
import 'package:http/http.dart' as http;

class PostNote {
  String message;

  PostNote({required this.message});

  factory PostNote.createPostNote(Map<String, dynamic> object) {
    return PostNote(
      message: object["message"],
    );
  }

  static Future<PostNote> connectToAPI(
      String judul, String isi, String user, String token) async {
    String url = "https://catetinnote.herokuapp.com/note/insert";
    var apiResult = await http.post(Uri.parse(url),
        body: {"judul": judul, "isi": isi, "user": user, "token": token});
    var jsonObject = json.decode(apiResult.body.toString());

    return PostNote.createPostNote(jsonObject);
  }
}
