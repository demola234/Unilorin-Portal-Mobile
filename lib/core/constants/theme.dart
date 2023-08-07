
import 'package:flutter/material.dart';
import 'package:probitas_app/core/constants/colors.dart';

ThemeData themes() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: ProbitasColor.ProbitasTextPrimary,
        onPrimary: ProbitasColor.ProbitasTextPrimary,
        onSurface: ProbitasColor.ProbitasSecondary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: ProbitasColor.ProbitasSecondary,
        ),
      ),
    );
  }


  ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: ProbitasColor.ProbitasSecondary,
        onPrimary: ProbitasColor.ProbitasTextPrimary,
        onSurface: ProbitasColor.ProbitasSecondary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: ProbitasColor.ProbitasSecondary,
        ),
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2A),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: ProbitasColor.ProbitasPrimary,
      ),
    );
  }
