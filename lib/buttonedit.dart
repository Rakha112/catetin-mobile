import 'package:catetin/controller/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditButton extends StatelessWidget {
  const EditButton({Key? key}) : super(key: key);
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
        noteController.isEdit.value = false;
      },
      child: ListTile(
        leading: const Icon(Icons.mode_edit_outlined),
        title: Text(
          "Edit",
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
