import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_colors.dart';
import 'constants/app_constants.dart';
import 'constants/app_strings.dart';
import 'firebase_options.dart';
import 'ui/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: blackColor,
              ), // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      initialRoute: RoutePaths.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.size,
      debugShowCheckedModeBanner: false,
    );
  }
}

