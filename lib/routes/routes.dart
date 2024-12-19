import 'package:get/get.dart';

import '../view/screen/Detailpage.dart';
import '../view/screen/home.dart';
import '../view/screen/login.dart';
import '../view/screen/sign in.dart';
import '../view/screen/splash.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const details = '/details';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => Login()),
    GetPage(
      name: signup,
      page: () => SignupPage(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: details,
      page: () => NoteDetailsPage(),
    ),
  ];
}
