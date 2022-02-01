import 'package:catetin/api/getnote.dart';
import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/securestorage.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNoteList();
  }

  final loginController = Get.find<LoginController>();
  final noteList = [].obs;
  // final isNote = false.obs;
  final isEdit = true.obs;
  final judul = "".obs;
  final isi = "".obs;
  final newIsi = "".obs;

  Future<dynamic> getNoteList() async {
    final SecureStorage secureStorage = SecureStorage();
    var token = await secureStorage.readSecureData('jwt');
    var username = await secureStorage.readSecureData('username');
    await GetNote.connectToAPI(
            token.toString(), username.toLowerCase().toString())
        .then(
      (value) {
        // ignore: prefer_is_empty
        if (value.length == 0) {
          noteList.value = ["Belum ada catatan"];
        } else {
          noteList.value = value.map((e) => e).toList();
        }
      },
    );
  }
}
