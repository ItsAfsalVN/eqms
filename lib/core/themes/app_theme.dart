import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xFF013CA6);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  
  static const Color secondaryColor = Color(0xFFFF7B6E);
  static const Color onSecondaryColor = Color(0xFFFFFFFF);

  static const Color backgroundColorLight = Color(0xFFF1F6FF);
  static const Color surfaceColorLight = Color(0xFFFFFFFF);
  static const Color onSurfaceColorLight = Color(0xFF013CA6);

  static const Color backgroundColorDark = Color(0xFF0F0F0F);
  static const Color surfaceColorDark = Color(0xFF1F1F1F);
  static const Color onSurfaceColorDark = Color(0xFFFF7B6E);

  static const Color errorColor = Color(0xFFFF3A3A);
  static const Color onErrorColor = Color(0xFFFFFFFF);

  static const Color successColor = Color(0xFF00B521);
  static const Color onSuccessColor = Color(0xFFFFFFFF);
}

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        primary: AppColors.primaryColor,          // #013CA6
        onPrimary: AppColors.onPrimaryColor,      // #FFFFFF
        secondary: Color(0xFF7DA2F7),             // #7DA2F7 (Role text)
        onSecondary: AppColors.onSecondaryColor,  // #FFFFFF
        surface: AppColors.surfaceColorLight,     // #FFFFFF
        onSurface: AppColors.onSurfaceColorLight, // #013CA6
        onSurfaceVariant: Color(0xFF99B3DE),      // #99B3DE (Subtitle)
        outline: Color(0xFFDCE7FC),               // Card border
        outlineVariant: Color(0xFFB9CFFE),        // Section line
        error: AppColors.errorColor,
        onError: AppColors.onErrorColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColorLight,
      dividerColor: const Color(0xFFE5EEFF),
      unselectedWidgetColor: const Color(0xFF7E8088),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        primary: AppColors.secondaryColor,         // #FF7B6E (Accent Coral)
        onPrimary: AppColors.onSecondaryColor,     // #FFFFFF
        secondary: Color(0xFF7DA2F7),             // #7DA2F7 (Role text)
        onSecondary: AppColors.onSecondaryColor,  // #FFFFFF
        surface: AppColors.surfaceColorDark,       // #1F1F1F
        onSurface: Color(0xFFFFFFFF),             // #FFFFFF (White title text)
        onSurfaceVariant: Color(0xFFA0A0A0),      // Subtitle
        outline: Color(0xFF333333),               // Card border dark
        outlineVariant: Color(0xFF444444),        // Section line dark
        error: AppColors.errorColor,
        onError: AppColors.onErrorColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColorDark,
      dividerColor: const Color(0xFF2C2C2C),
      unselectedWidgetColor: const Color(0xFF8A8A8A),
    );
  }
}