import 'package:authentication_app_exam/screen/auth/signup/signup_screen.dart';
import 'package:authentication_app_exam/screen/favourite/fav_user.dart';
import 'package:authentication_app_exam/screen/home/home_screen.dart';
import 'package:authentication_app_exam/screen/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String fav = '/fav';

  static List<GetPage> pagesGet = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
    GetPage(name: fav, page: () => const FavUser()),
    // AppRoutes.login: (context) => const ,

    // AppRoutes.fav: (context) => const
  ];

  AppRoutes._();
  static final AppRoutes appRoutes = AppRoutes._();
}
