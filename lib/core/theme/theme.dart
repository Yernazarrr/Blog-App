import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static _setBorder([Color borderColor = AppColors.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppColors.backgroundColor),
      side: BorderSide.none,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _setBorder(),
      focusedBorder: _setBorder(AppColors.gradient2),
    ),
  );
}
