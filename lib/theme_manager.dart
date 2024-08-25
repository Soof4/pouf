import 'package:flutter/material.dart';

class ThemeManager {
  ThemeManager._(); // Disable instantiation

  static const Color _white = Color.fromRGBO(250, 250, 255, 1);
  static const Color _black = Color.fromRGBO(25, 25, 25, 1);
  static const Color _accent = Color.fromRGBO(238, 144, 37, 1);

  static const Color _whiteDark = Color.fromRGBO(35, 35, 36, 1);
  static const Color _accentDark = Color.fromRGBO(199, 91, 18, 1);

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _accent,
      onPrimary: _white,
      secondary: _white,
      onSecondary: _black,
      error: Color.fromRGBO(135, 35, 65, 1),
      onError: Color.fromRGBO(255, 255, 255, 1),
      surface: Color.fromRGBO(249, 246, 247, 1),
      onSurface: _black,
      tertiary: Color.fromRGBO(255, 232, 214, 1),
      onTertiary: _black,
    ),
    cardTheme: const CardTheme(
      elevation: 2,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _accent,
      foregroundColor: _white,
      elevation: 2,
      shadowColor: _black,
      actionsIconTheme: IconThemeData(
        color: _white,
      ),
      iconTheme: IconThemeData(
        color: _white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _accentDark,
      onPrimary: _whiteDark,
      secondary: _whiteDark,
      onSecondary: _white,
      error: Color.fromRGBO(135, 35, 65, 1),
      onError: Color.fromRGBO(255, 255, 255, 1),
      surface: _whiteDark,
      onSurface: _white,
      tertiary: Color.fromRGBO(255, 232, 214, 1),
      onTertiary: _white,
      shadow: _black,
    ),
    cardTheme: const CardTheme(
      elevation: 2,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _accentDark,
      foregroundColor: _white,
      elevation: 2,
      shadowColor: _black,
      actionsIconTheme: IconThemeData(
        color: _whiteDark,
      ),
      iconTheme: IconThemeData(
        color: _whiteDark,
      ),
    ),
  );
}
