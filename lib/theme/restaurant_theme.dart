import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/restaurant_text_style.dart';

class RestaurantTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyle.displayLarge,
      displayMedium: RestaurantTextStyle.displayMedium,
      displaySmall: RestaurantTextStyle.displaySmall,
      headlineLarge: RestaurantTextStyle.headlineLarge,
      headlineMedium: RestaurantTextStyle.headlineMedium,
      headlineSmall: RestaurantTextStyle.headlineSmall,
      titleLarge: RestaurantTextStyle.titleLarge,
      titleMedium: RestaurantTextStyle.titleMedium,
      titleSmall: RestaurantTextStyle.titleSmall,
      bodyLarge: RestaurantTextStyle.bodyLargeBold,
      bodyMedium: RestaurantTextStyle.bodyLargeMedium,
      bodySmall: RestaurantTextStyle.bodyLargeRegular,
      labelLarge: RestaurantTextStyle.labelLarge,
      labelMedium: RestaurantTextStyle.labelMedium,
      labelSmall: RestaurantTextStyle.labelSmall,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: Color.fromRGBO(0, 121, 21, 1),
      brightness: Brightness.light,
      textTheme: _textTheme,
      appBarTheme:
          AppBarTheme(backgroundColor: Color.fromARGB(255, 134, 169, 140)),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: const Color.fromRGBO(0, 121, 21, 1),
      brightness: Brightness.dark,
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 1, 39, 7)),
      useMaterial3: true,
    );
  }
}
