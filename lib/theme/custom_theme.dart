import 'package:flutter/material.dart';

/**
 * @author Giovane Neves
 */
class CustomTheme {

  static const Color primaryColor = Color(0xFF2D2D2D);    // Preto // Amarelo
  static const Color backgroundColor = Color(0xFFffffff); // Branco
  static const Color textColor = Color(0xFFF6D13A);       // Amarelo // Marrom

  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: _textTheme(textColor),
      elevatedButtonTheme: _elevatedButtonTheme(primaryColor, backgroundColor),
      inputDecorationTheme: _inputDecorationTheme(textColor),
    );
  }

  // Tema escuro
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      textTheme: _textTheme(Colors.white),
      elevatedButtonTheme: _elevatedButtonTheme(primaryColor, backgroundColor),
      inputDecorationTheme: _inputDecorationTheme(Colors.white),
    );
  }

  // Método para o TextTheme
  static TextTheme _textTheme(Color color) {
    return TextTheme(
      bodyLarge: TextStyle(color: color),
      bodyMedium: TextStyle(color: color),
      headlineSmall: TextStyle(color: color),
    );
  }



  // Método para o ElevatedButtonThemeData
  static ElevatedButtonThemeData _elevatedButtonTheme(
      Color backgroundColor, Color foregroundColor) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Método para o InputDecorationTheme
  static InputDecorationTheme _inputDecorationTheme(Color color) {
    return InputDecorationTheme(
      labelStyle: TextStyle(color: color),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
