import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // backgroundColor: const Color(0xFF1976D2),
        textStyle: TextStyles.instance.textButton,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFBDBDBD)),
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0x99615F5F),
        ),
      ),
      fillColor: const Color(0xFFFFFFFF),
      filled: true,
      hintStyle: TextStyles.instance.textRegular
          .copyWith(fontSize: 14, color: const Color(0xFF9E9E9E)),
      labelStyle: TextStyles.instance.textRegular.copyWith(fontSize: 14),
    ),
  );
}
