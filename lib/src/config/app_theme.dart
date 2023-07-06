import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.electricRuby,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.darkForestGreen,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.electricRuby),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: AppColors.electricRuby),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.electricRuby,
      ),
      titleMedium: GoogleFonts.lato(
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.platinumGray),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.darkForestGreen,
    ),
    cardColor: Colors.grey.shade800,
    scaffoldBackgroundColor: AppColors.darkForestGreen,
    iconTheme: const IconThemeData(color: AppColors.electricRuby),
  );
}
