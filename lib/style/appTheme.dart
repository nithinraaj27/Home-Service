import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/sizeconfig.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData(

    focusColor: Colors.blueAccent,
      textTheme: TextTheme(
          subtitle1: GoogleFonts.poppins(
              color: Color(0xff23ADE8),
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.height! * 3.2
          ),
          subtitle2: GoogleFonts.poppins(
              fontSize: SizeConfig.height! * 2.5,
              color: Colors.white,
              fontWeight: FontWeight.w500
          ),
        headline3: GoogleFonts.poppins(
            fontSize: SizeConfig.height! * 2,
            color: Colors.black,
            fontWeight: FontWeight.w500
        )
      ));
}
