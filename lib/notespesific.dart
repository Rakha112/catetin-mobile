import 'package:catetin/buttondelete.dart';
import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/buttonedit.dart';
import 'package:catetin/buttonsave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteSpesific extends StatefulWidget {
  const NoteSpesific({Key? key}) : super(key: key);

  @override
  State<NoteSpesific> createState() => _NoteSpesificState();
}

final loginController = Get.find<LoginController>();
final noteController = Get.find<NoteController>();

class _NoteSpesificState extends State<NoteSpesific> {
  final isi = TextEditingController(text: noteController.isi.value);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
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
                      height: 150,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Obx(() => noteController.isEdit.value == false
                                ? const SaveButton()
                                : const EditButton()),
                            const DeleteButton(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black26),
                    ),
                  ),
                  child: Text(
                    noteController.judul.value,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: Obx(
                    () => TextFormField(
                      onChanged: ((e) {
                        noteController.isi.value = e;
                      }),
                      readOnly: noteController.isEdit.value,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: isi,
                      cursorColor: Colors.black,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
    );
  }
}
