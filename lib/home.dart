import 'package:catetin/animation.dart';
import 'package:catetin/button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulHookWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    print(brightness);
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "image/CATETIN2.png",
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                "CATETIN",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                )),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: FadeAnimation(
                0.5,
                Image.asset(
                  "image/CATETIN.png",
                  width: 280,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 36.h, left: 45.w, right: 45.w),
              child: FadeAnimation(
                0.7,
                Text(
                  "CATETIN merupakan tempat untuk menulis dan mencatat apapun yang ingin anda tulis dan catat",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: const FadeAnimation(
                0.9,
                Button(
                  textbtn: "Sign Up",
                  warnabg: 0xFF000000,
                  warnatxt: 0xFFFFFFFF,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: const FadeAnimation(
                1.1,
                Button(
                  textbtn: "Log in",
                  warnabg: 0xFFF5F5F5,
                  warnatxt: 0xFF000000,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
