import 'package:catetin/api/putupdatenote.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/newnote.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        primary: Colors.white, // background (button) color
        onPrimary: Colors.black,
      ),
      onPressed: () {
        Get.back();
        Get.back();
        noteController.isEdit.value = true;
        UpdateNote.connectToAPI(
                noteController.judul.toString(),
                noteController.isi.toString(),
                loginController.usernamee.toString(),
                loginController.token.toString())
            .then((value) {
          noteController.getNoteList();
          Get.snackbar(
            "CATETIN",
            "Berhasil mengubah catatan",
            backgroundColor: const Color(0xffedf7ed),
            colorText: const Color(0xff1e4620),
            icon: const Icon(
              Icons.check,
              color: Color(0xff4caf50),
            ),
            shouldIconPulse: false,
          );
        });
      },
      child: ListTile(
        leading: const Icon(Icons.save_alt_rounded),
        title: Text(
          "Save",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
