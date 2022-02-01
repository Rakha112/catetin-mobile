import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final int warnabg;
  final int warnatxt;
  final String textbtn;

  const Button(
      {Key? key,
      required this.warnabg,
      required this.warnatxt,
      required this.textbtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: TextButton(
          onPressed: () => {
            textbtn == "Log in" ? Get.toNamed("/login") : Get.toNamed("/signup")
          },
          style: TextButton.styleFrom(
              backgroundColor: Color(warnabg),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Text(
            textbtn,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Color(warnatxt),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
