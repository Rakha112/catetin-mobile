import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/controller/note_controller.dart';
import 'package:catetin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: null,
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true, // transparent status bar
    ),
  );

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // ignore: unused_local_variable
    final loginController = Get.put(LoginController());
    // ignore: unused_local_variable
    final notenController = Get.put(NoteController());

    return ScreenUtilInit(
      designSize: const Size(393, 856),
      builder: () => GetMaterialApp(
        initialRoute: '/',
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1),
        getPages: Routes.routes,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Color(0xFF000000),
            ),
            bodyText2: TextStyle(
              color: Color(0xFF000000),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
