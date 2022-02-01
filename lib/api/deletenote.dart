import 'dart:convert';
import 'package:http/http.dart' as http;

class DeleteNote {
  String message;

  DeleteNote({required this.message});

  factory DeleteNote.createDeleteNote(Map<String, dynamic> object) {
    return DeleteNote(
      message: object["message"],
    );
  }

  static Future<DeleteNote> connectToAPI(
      String judul, String isi, String user, String token) async {
    String url = "https://catetinnote.herokuapp.com/note/delete";
    var apiResult = await http.delete(Uri.parse(url),
        body: {"judul": judul, "isi": isi, "user": user, "token": token});
    var jsonObject = json.decode(apiResult.body.toString());

    return DeleteNote.createDeleteNote(jsonObject);
  }
}
