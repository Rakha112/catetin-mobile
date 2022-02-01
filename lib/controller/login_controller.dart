import 'dart:developer';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/controller/securestorage.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getLogin().then(
      (value) {
        isLogin.value = value;
      },
    );
    getUsername().then(
      (value) {
        usernamee.value = value;
      },
    );
    getToken().then(
      (value) {
        final SecureStorage secureStorage = SecureStorage();
        final noteController = Get.find<NoteController>();
        if(value != null) {
        log("TOKEN " + value);
        bool hasExpired = Jwt.isExpired(value);
        log("EXP " + hasExpired.toString());
        if (hasExpired) {
          logout();
          secureStorage.deleteSecureData('login');
          secureStorage.deleteSecureData('jwt');
          secureStorage.deleteSecureData('username');
          usernamee.value = "";
          token.value = "";
          noteController.noteList.value = [];
        }
        }
        token.value = value;
      },
    );
  }

  final isLogin = false.obs;
  final usernamee = "".obs;
  final token = "".obs;

  login() => isLogin.value = true;
  logout() => isLogin.value = false;
}

Future<dynamic> getLogin() async {
  final SecureStorage secureStorage = SecureStorage();
  var login = await secureStorage.readSecureData('login');
  if (login == null) {
    return false;
  }
  if (login.toLowerCase() == 'true') {
    return true;
  }
}

Future<dynamic> getUsername() async {
  final SecureStorage secureStorage = SecureStorage();

  var username = await secureStorage.readSecureData('username');
  if (username == null) {
    return "";
  }
  return username;
}

Future<dynamic> getToken() async {
  final SecureStorage secureStorage = SecureStorage();

  var token = await secureStorage.readSecureData('jwt');
  if (token == null) {
    return "";
  }
  return token;
}
