import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF0B5138);
  static const Color titleTextColor = Color(0xFF0B5138);
  static const Color backgroundColor = Color(0xFFF7F9F6);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color bodyTextColor = Color(0xFF6F6A6A);
  static const Color hintColor = Color(0xFF9E9D9D);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color infoColor = Color(0xFF1E88E5);
  static const Color onBoardingBody = Color(0xFF1E88E5);
  static const Color warningColor = Color(0xFFFFB300);
  static const Color placeholderGrey = Color(0xFFD9D9D9);
  static const Color ratingStar = Color(0xFFF0C24D);
  static const Color ratingStarDark = Color(0xFFEDB310);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0B5138), Color(0xFF19B77F)],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );


  
  static const LinearGradient navbarNotchGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF19B77F),Color(0xFF19B77F), Color(0xFF0B5138)],
  );

  static const Color navbarNotchShadowColor = Color(0xFF067C52);

  
  static const LinearGradient navbarBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFBDBDBD), Color(0xFFD6D6D6)],
  );

  static const Color navBarInactiveIconColor = whiteColor;
  static const Color navBarInactiveLabelColor = whiteColor;

  static const Color smallFontColor = Color(0xFF9E9D9D);
}