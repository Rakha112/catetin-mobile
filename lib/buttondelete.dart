import 'package:catetin/api/deletenote.dart';
import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    final loginController = Get.find<LoginController>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        primary: Colors.white, // background (button) color
        onPrimary: Colors.black,
      ),
      onPressed: () {
        Get.back();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Delete'),
            content: const Text('Apakah anda ingin menghapus Catatan ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                  DeleteNote.connectToAPI(
                          noteController.judul.toString(),
                          noteController.isi.toString(),
                          loginController.usernamee.toString(),
                          loginController.token.toString())
                      .then(
                    (value) {
                      noteController.getNoteList();
                      Get.snackbar(
                        "CATETIN",
                        "Berhasil menghapus catatan",
                        backgroundColor: const Color(0xffedf7ed),
                        colorText: const Color(0xff1e4620),
                        icon: const Icon(
                          Icons.check,
                          color: Color(0xff4caf50),
                        ),
                        shouldIconPulse: false,
                      );
                    },
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      child: ListTile(
        leading: const Icon(Icons.delete_outline),
        title: Text(
          "Delete",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
