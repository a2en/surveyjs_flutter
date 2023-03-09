import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:surveyjs_projile/constants/app_constants.dart';
import 'package:surveyjs_projile/ui/screens/form/form_controller.dart';
import 'package:surveyjs_projile/ui/screens/form/form_screen.dart';
import 'package:surveyjs_projile/ui/screens/home/home_controller.dart';
import 'package:surveyjs_projile/ui/screens/home/home_screen.dart';
import 'package:surveyjs_projile/utils/binding.dart';
import 'screens/splash/splash_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: RoutePaths.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutePaths.home,
      binding: Binding<HomeController>(() => HomeController()),
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: RoutePaths.form,
      binding: Binding<FormController>(() => FormController()),
      page: () => const FormScreen(),
    ),
  ];
}

