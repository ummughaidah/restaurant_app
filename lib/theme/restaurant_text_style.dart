import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantTextStyle {
  static final TextStyle _fontStyle = GoogleFonts.overpass();

  static TextStyle displayLarge = _fontStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w700,
  );

  static TextStyle displayMedium = _fontStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
  );

  static TextStyle displaySmall = _fontStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headlineLarge = _fontStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineMedium = _fontStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headlineSmall = _fontStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleLarge = _fontStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleMedium = _fontStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleSmall = _fontStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyLargeBold = _fontStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyLargeMedium = _fontStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyLargeRegular = _fontStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w200,
  );

  static TextStyle labelLarge = _fontStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static TextStyle labelMedium = _fontStyle.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w200,
  );

  static TextStyle labelSmall = _fontStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w100,
  );
}
