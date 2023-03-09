import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';


class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final double? height;
  final double? fontSize;
  final bool isLoading;
  const PrimaryButton({
    Key? key,
    this.onPressed, required this.text,this.color=secondaryColor,this.height,this.fontSize,this.isLoading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??44.0,
      child: ElevatedButton(
        onPressed: (){
          if(!isLoading&&onPressed!=null){
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0.1,
          backgroundColor: color??secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isLoading ? const SizedBox(width:30,height:30,child: CircularProgressIndicator()) : Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize??17,
            color: whiteColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
