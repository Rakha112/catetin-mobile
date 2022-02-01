import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateNote {
  String message;

  UpdateNote({required this.message});

  factory UpdateNote.createUpdateNote(Map<String, dynamic> object) {
    return UpdateNote(
      message: object["message"],
    );
  }

  static Future<UpdateNote> connectToAPI(
      String judul, String isi, String user, String token) async {
    String url = "https://catetinnote.herokuapp.com/note/update";
    var apiResult = await http.put(Uri.parse(url),
        body: {"judul": judul, "isi": isi, "user": user, "token": token});
    var jsonObject = json.decode(apiResult.body.toString());

    return UpdateNote.createUpdateNote(jsonObject);
  }
}
