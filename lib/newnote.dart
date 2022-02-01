import 'package:catetin/animation.dart';
import 'package:catetin/api/postnote.dart';
import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

final judul = TextEditingController();
final isi = TextEditingController();
final loginController = Get.find<LoginController>();
final noteController = Get.find<NoteController>();

class _NewNoteState extends State<NewNote> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: WillPopScope(
        onWillPop: (() {
          Get.back();
          return Future.value(false);
        }),
        child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
                judul.text = "";
                isi.text = "";
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                // size: 28.0,
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5.w),
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    Get.bottomSheet(
                      SizedBox(
                        height: 100.w,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Column(
                            children: [
                              SizedBox(height: 15.h),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent,
                                  primary:
                                      Colors.white, // background (button) color
                                  onPrimary: Colors.black,
                                ),
                                onPressed: () {
                                  Get.back();
                                  if (judul.text == "") {
                                    Get.snackbar(
                                      "CATETIN",
                                      "Judul tidak boleh kosong",
                                      backgroundColor: const Color(0xfffdeded),
                                      colorText: const Color(0xff5f2120),
                                      icon: const Icon(
                                        Icons.error_outline_rounded,
                                        color: Color(0xffef5350),
                                      ),
                                      shouldIconPulse: false,
                                    );
                                  } else {
                                    Get.back();
                                    PostNote.connectToAPI(
                                            judul.text,
                                            isi.text,
                                            loginController.usernamee
                                                .toLowerCase()
                                                .toString(),
                                            loginController.token.toString())
                                        .then(
                                      (value) {
                                        noteController.getNoteList();
                                        Get.snackbar(
                                          "CATETIN",
                                          "Berhasil menambahkan catatan",
                                          backgroundColor:
                                              const Color(0xffedf7ed),
                                          colorText: const Color(0xff1e4620),
                                          icon: const Icon(
                                            Icons.check,
                                            color: Color(0xff4caf50),
                                          ),
                                          shouldIconPulse: false,
                                        );
                                      },
                                    );
                                    judul.text = "";
                                    isi.text = "";
                                  }
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Form(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35.w),
                  child: FadeAnimation(
                    0.7,
                    TextFormField(
                      controller: judul,
                      cursorColor: Colors.black,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      decoration: const InputDecoration(
                        // border: InputBorder.none,
                        labelStyle: TextStyle(
                          color: Color(0xFF000000),
                        ),
                        hintText: "Judul...",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    child: FadeAnimation(
                      0.9,
                      TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: isi,
                        cursorColor: Colors.black,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle: const TextStyle(
                            color: Color(0xFF000000),
                          ),
                          hintText: "Isikan note di sini...",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 35.w, vertical: 10.h),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
