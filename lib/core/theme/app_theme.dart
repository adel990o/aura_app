import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppTheme {
  static const Color background = Color(0xFF000000);
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color textGold = Color(0xFFFFD700);
  static const Color cardBackground = Color(0xFF1C1C1E);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93);

  static Color goldOpacity10 = primaryGold.withOpacity(0.1);
  static Color goldOpacity20 = primaryGold.withOpacity(0.2);
  static Color goldOpacity40 = primaryGold.withOpacity(0.4);
  static Color cardBackground80 = cardBackground.withOpacity(0.8);
  static Color cardBackground70 = cardBackground.withOpacity(0.7);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryGold,
      fontFamily: 'SFProArabic',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryGold),
        titleTextStyle: TextStyle(color: textGold, fontSize: 24, fontWeight: FontWeight.w700),
      ),
      textTheme: const TextTheme(bodyLarge: TextStyle(color: textWhite), bodyMedium: TextStyle(color: textWhite)),
    );
  }

  static TextStyle get goldTitleStyle => const TextStyle(color: textGold, fontSize: 24, fontWeight: FontWeight.w700);
  static TextStyle get goldSubtitleStyle => TextStyle(color: textGold.withOpacity(0.9), fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle get whiteBodyStyle => const TextStyle(color: textWhite, fontSize: 18, height: 1.5);
  static TextStyle get secondaryTextStyle => TextStyle(color: primaryGold.withOpacity(0.6), fontSize: 12);

  static ImageFilter get glassBlur => ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0);
  static ImageFilter get cardBlur => ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);

  static LinearGradient get goldCardGradient => LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [primaryGold.withOpacity(0.15), cardBackground.withOpacity(0.4)],
  );

  static List<BoxShadow> get goldenGlow => [BoxShadow(color: primaryGold.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)];
  static List<BoxShadow> get blackShadow => [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 4))];
  static BorderRadius get largeBorderRadius => BorderRadius.circular(24);
  static BorderRadius get xLargeBorderRadius => BorderRadius.circular(32);
  static BorderRadius get mediumBorderRadius => BorderRadius.circular(16);
}
