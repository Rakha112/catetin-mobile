import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/securestorage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLogout extends StatefulWidget {
  final int warnabg;
  final int warnatxt;
  final String textbtn;

  const ButtonLogout({
    Key? key,
    required this.warnabg,
    required this.warnatxt,
    required this.textbtn,
  }) : super(key: key);

  @override
  State<ButtonLogout> createState() => _ButtonLogoutState();
}

class _ButtonLogoutState extends State<ButtonLogout> {
  final SecureStorage secureStorage = SecureStorage();
  final loginController = Get.find<LoginController>();
  // final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: TextButton(
          onPressed: () => {
            secureStorage.deleteSecureData('login'),
            secureStorage.deleteSecureData('username'),
            loginController.usernamee.value = "",
            loginController.logout(),
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
