import 'package:catetin/controller/login_controller.dart';
import 'package:catetin/home.dart';
import 'package:catetin/login.dart';
import 'package:catetin/notepage.dart';
import 'package:catetin/notespesific.dart';
import 'package:catetin/signup.dart';
import 'package:get/get.dart';

final loginController = Get.put(LoginController());
final _defaultHome = Obx(() =>
    loginController.isLogin.value ? const NotePage() : const MyHomePage());

class Routes {
  static final routes = [
    GetPage(
        name: '/',
        page: () => _defaultHome,
        transition: Transition.noTransition),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/signup', page: () => const SignupPage()),
    GetPage(name: '/note', page: () => const NoteSpesific()),
    GetPage(
        name: '/note2',
        page: () => const NotePage(),
        transition: Transition.noTransition),
    // GetPage(
    //     name: '/newnote',
    //     page: () => NewNote(),
    //     transitionDuration: const Duration(milliseconds: 5000),
    //     transition: Transition.zoom),
  ];
}
