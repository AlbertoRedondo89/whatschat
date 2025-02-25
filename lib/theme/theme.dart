import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';


// 🔹 Tema Claro
final ThemeData appThemeLight = ThemeData(
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(fontSize: 16, color: AppColors.textLight),
    titleLarge: GoogleFonts.poppins(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.textLight),
    labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textLight),
  ),
  iconTheme: IconThemeData(color: AppColors.textLight),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 4,
    shadowColor: AppColors.shadowLight,
  ),
);

// 🔹 Tema Oscuro
final ThemeData appThemeDark = ThemeData(
  primaryColor: AppColors.primaryDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary),
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(fontSize: 16, color: AppColors.textDark),
    titleLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
    labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textDark),
  ),
  iconTheme: IconThemeData(color: AppColors.textDark),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.shadowDark,
    elevation: 4,
    shadowColor: AppColors.shadowDark
  ),
);