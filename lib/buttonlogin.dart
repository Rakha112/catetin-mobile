import 'package:catetin/api/postprofile.dart';
import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/controller/securestorage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api/postreqlogin.dart';
import 'package:jwt_decode/jwt_decode.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLogin extends StatefulWidget {
  final int warnabg;
  final int warnatxt;
  final String textbtn;
  final TextEditingController username;
  final TextEditingController password;

  const ButtonLogin({
    Key? key,
    required this.warnabg,
    required this.warnatxt,
    required this.textbtn,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  String message = "";
  final SecureStorage secureStorage = SecureStorage();
  final loginController = Get.find<LoginController>();
  final noteController = Get.find<NoteController>();
  // final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: TextButton(
          onPressed: () => {
            if (widget.username.text.isNotEmpty &&
                widget.password.text.isNotEmpty)
              {
                PostLogin.connectToAPI(
                        widget.username.text, widget.password.text)
                    .then(
                  (value) {
                    secureStorage.writeSecureData('jwt', value.token);
                    loginController.token.value = value.token;
                    message = value.message;
                    if (value.alert == 2) {
                      Map<String, dynamic> payload = Jwt.parseJwt(value.token);
                      loginController.usernamee.value = payload["username"];
                      secureStorage.writeSecureData('login', "true");
                      loginController.login();
                      GetProfile.connectToAPI(value.token).then(
                        (value) => {
                          secureStorage.writeSecureData(
                              'username',
                              value.username[0].toUpperCase() +
                                  value.username.substring(1)),
                          loginController.usernamee.value =
                              value.username[0].toUpperCase() +
                                  value.username.substring(1),
                          noteController.getNoteList(),
                          Get.offAllNamed('/'),
                        },
                      );
                    } else if (value.alert == 3) {
                      Get.snackbar(
                        "CATETIN",
                        message,
                        backgroundColor: const Color(0xfffdeded),
                        colorText: const Color(0xff5f2120),
                        icon: const Icon(
                          Icons.error_outline_rounded,
                          color: Color(0xffef5350),
                        ),
                        shouldIconPulse: false,
                      );
                    }
                  },
                ),
              },
            if (widget.username.text.isEmpty || widget.password.text.isEmpty)
              {
                Get.snackbar(
                  "CATETIN",
                  "Username atau Password tidak boleh kosong",
                  backgroundColor: const Color(0xfffff4e5),
                  colorText: const Color(0xff663c00),
                  icon: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xffff9800),
                  ),
                  shouldIconPulse: false,
                ),
              },
          },
          style: TextButton.styleFrom(
              backgroundColor: Color(widget.warnabg),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Text(widget.textbtn,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color(widget.warnatxt),
                      fontWeight: FontWeight.w500,
                      fontSize: 18))),
        ),
      ),
    );
  }
}
