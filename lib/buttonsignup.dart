import 'package:catetin/api/postreqsignup.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonSignup extends StatefulWidget {
  final int warnabg;
  final int warnatxt;
  final String textbtn;
  final TextEditingController username;
  final TextEditingController password;

  const ButtonSignup({
    Key? key,
    required this.warnabg,
    required this.warnatxt,
    required this.textbtn,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  State<ButtonSignup> createState() => _ButtonSignupState();
}

class _ButtonSignupState extends State<ButtonSignup> {
  String message = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: TextButton(
          onPressed: () => {
            if (widget.username.text.isNotEmpty &&
                widget.password.text.isNotEmpty)
              {
                PostSignup.connectToAPI(
                        widget.username.text, widget.password.text)
                    .then(
                  (value) {
                    message = value.message;
                    if (value.alert == 2) {
                      Get.snackbar(
                        "CATETIN",
                        message,
                        backgroundColor: const Color(0xffedf7ed),
                        colorText: const Color(0xff1e4620),
                        icon: const Icon(
                          Icons.check,
                          color: Color(0xff4caf50),
                        ),
                        shouldIconPulse: false,
                      );
                    }
                    if (value.alert == 3) {
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
          child: Text(
            widget.textbtn,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color(widget.warnatxt),
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp),
            ),
          ),
        ),
      ),
    );
  }
}
