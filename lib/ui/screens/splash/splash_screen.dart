import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async{
      Get.offAndToNamed(RoutePaths.home);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE6),
      body: Center(
        child: Text(
          Strings.appName,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.w300,
          )
        )
      )
    );
  }
}
