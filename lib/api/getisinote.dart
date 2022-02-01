import 'dart:convert';
import 'package:http/http.dart' as http;

class GetIsiNote {
  String isi;

  GetIsiNote({required this.isi});

  factory GetIsiNote.createGetIsiNote(Map<String, dynamic> object) {
    return GetIsiNote(
      isi: object["isi"],
    );
  }

  static Future<GetIsiNote> connectToAPI(
      String token, String username, String judul) async {
    final url = Uri.https("catetinnote.herokuapp.com", "/note/isi",
        {"token": token, "user": username.toLowerCase(), "judul": judul});
    var apiResult = await http.get(url);
    var jsonObject = json.decode(apiResult.body);

    return GetIsiNote.createGetIsiNote(jsonObject);
  }
}
