import 'package:flutter/material.dart';
import 'package:movirent/ui/styles/ui_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        foregroundColor: secondary,
        backgroundColor: primary
      ),
   );
}