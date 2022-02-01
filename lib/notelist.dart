import 'package:animations/animations.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/notespesific.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteList extends StatefulWidget {
  final String judul;
  final String isi;

  const NoteList({Key? key, required this.judul, required this.isi})
      : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final noteController = Get.find<NoteController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h, left: 24.w, right: 24.w),
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 1000),
        closedColor: const Color(0xfff4f6f8),
        closedBuilder: (BuildContext c, VoidCallback action) {
          return GestureDetector(
            onTap: () {
              noteController.isi.value = widget.isi;
              noteController.judul.value = widget.judul;
              action();
              // Get.toNamed('/note');
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xfff4f6f8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffe6ecfc),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'image/note.svg',
                        height: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      widget.judul,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        openBuilder: (BuildContext c, openContainer) => const NoteSpesific(),
        tappable: false,
        closedElevation: 0,
        openElevation: 0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
