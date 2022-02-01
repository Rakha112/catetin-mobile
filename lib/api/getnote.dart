import 'dart:convert';
import 'package:http/http.dart' as http;

class GetNote {
  String judul;
  String isi;
  String status;

  GetNote({required this.judul, required this.isi, required this.status});

  factory GetNote.createGetNote(Map<String, dynamic> object) {
    return GetNote(
      judul: object["judul"],
      isi: object["isi"],
      status: object["status"],
    );
  }

  static Future<List<GetNote>> connectToAPI(
      String token, String username) async {
    List<GetNote> noteList = [];
    final url = Uri.https("catetinnote.herokuapp.com", "/note",
        {"token": token, "user": username.toLowerCase()});
    var apiResult = await http.get(url);
    var jsonObject = json.decode(apiResult.body);
    for (var prod in jsonObject) {
      noteList.add(GetNote.createGetNote(prod));
    }
    return noteList;
  }
}
