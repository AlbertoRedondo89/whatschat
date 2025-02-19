import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF075E54); // Verde WhatsApp
  static const Color secondary = Color(0xFF128C7E);
  static const Color accent = Color(0xFF25D366);
  static const Color background = Color(0xFFECE5DD);
  static const Color text = Colors.black87;
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColors.text),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      foregroundColor: Colors.white,
    ),
  ),
);
