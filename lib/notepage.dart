// import 'package:catetin/controller/login_controller.dart';
import 'package:animations/animations.dart';
import 'package:catetin/api/getnote.dart';
import 'package:catetin/controller/securestorage.dart';
import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/newnote.dart';
import 'package:catetin/notelist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);
  @override
  _NotePageState createState() => _NotePageState();
}

late final String result;
late Future<List<GetNote>> note;
final loginController = Get.find<LoginController>();
final noteController = Get.find<NoteController>();
final SecureStorage secureStorage = SecureStorage();

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          titleSpacing: 0,
          leading: const Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
            size: 36,
          ),
          title: Obx(
            () => Text(
              "${loginController.usernamee}",
              style: const TextStyle(color: Color(0xFF000000)),
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
                      height: 100.h,
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
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Log Out'),
                                    content: const Text(
                                        'Apakah anda ingin Log Out ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          secureStorage
                                              .deleteSecureData('login');
                                          secureStorage.deleteSecureData('jwt');
                                          secureStorage
                                              .deleteSecureData('username');
                                          loginController.usernamee.value = "";
                                          loginController.token.value = "";
                                          loginController.logout();
                                          noteController.noteList.value = [];
                                          Get.back();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: const Icon(Icons.logout_rounded),
                                title: Text(
                                  "Log Out",
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
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () {
              return noteController.getNoteList();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () {
                    if (noteController.noteList.toString() ==
                        "[Belum ada catatan]") {
                      return Center(
                        child: Text(
                          "Belum ada catatan...",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      );
                    } else if (noteController.noteList.isNotEmpty) {
                      return Column(
                        children: noteController.noteList
                            .map(
                              (element) => NoteList(
                                judul: element.judul,
                                isi: element.isi,
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: const Color(0xfff4f6f8),
                        highlightColor: Colors.white,
                        child: Column(
                          children: const [
                            NoteList(judul: "aa", isi: "aa"),
                            NoteList(judul: "aa", isi: "aa"),
                            NoteList(judul: "aa", isi: "aa"),
                            NoteList(judul: "aa", isi: "aa"),
                            NoteList(judul: "aa", isi: "aa"),
                          ],
                        ), //Your custom layout comes here...
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButton: OpenContainer(
          transitionDuration: const Duration(milliseconds: 1000),
          closedColor: const Color(0xffd1e8fc),
          closedBuilder: (BuildContext c, VoidCallback action) {
            return SizedBox(
              height: 60.sp,
              width: 60.sp,
              child: Center(
                child: Image.asset(
                  "image/plus.png",
                  width: 30.sp,
                  height: 30.sp,
                ),
              ),
            );
          },
          openBuilder: (BuildContext c, openContainer) => const NewNote(),
          tappable: true,
          closedElevation: 6.0,
          openElevation: 0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
