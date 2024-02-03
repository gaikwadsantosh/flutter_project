import 'package:flutter/material.dart';

class AppColors {
  static Color accent = const Color(0xff1ab7c3);
  static Color text = Colors.black;
  static Color white = Colors.white;
  static Color textLight = const Color.fromARGB(255, 116, 105, 105);
  static Color titleText = Colors.blue;
}

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.text,
      ),
      titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.titleText),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.accent,
      secondary: AppColors.accent,
    ),
  );
}

class TextStyles {
  static TextStyle heading1 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 48);

  static TextStyle heading2 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 32);

  static TextStyle heading3 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 24);

  static TextStyle body1 = TextStyle(
      fontWeight: FontWeight.normal, color: AppColors.text, fontSize: 18);

  static TextStyle body2 = TextStyle(
      fontWeight: FontWeight.normal, color: AppColors.text, fontSize: 16);

  static TextStyle body3 = TextStyle(
      fontWeight: FontWeight.normal, color: AppColors.text, fontSize: 14);

  static TextStyle boldBody3 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 14);
}
