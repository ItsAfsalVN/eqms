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
  static TextTheme _buildTextTheme({
    required Color headingColor,
    required Color bodyColor,
    required Color labelColor,
  }) {
    return TextTheme(
      displayLarge: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
      ).copyWith(color: headingColor),
      displayMedium: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
      ).copyWith(color: headingColor),
      displaySmall: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
      ).copyWith(color: headingColor),
      headlineLarge: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
      ).copyWith(color: headingColor),
      headlineMedium: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
      ).copyWith(color: headingColor),
      headlineSmall: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
      ).copyWith(color: headingColor),
      titleLarge: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ).copyWith(color: bodyColor),
      titleMedium: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ).copyWith(color: bodyColor),
      titleSmall: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ).copyWith(color: bodyColor),
      bodyLarge: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400,
      ).copyWith(color: bodyColor),
      bodyMedium: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400,
      ).copyWith(color: bodyColor),
      bodySmall: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400,
      ).copyWith(color: bodyColor),
      labelLarge: const TextStyle(
        fontFamily: 'Viga',
        fontWeight: FontWeight.w400,
      ).copyWith(color: labelColor),
      labelMedium: const TextStyle(
        fontFamily: 'Viga',
        fontWeight: FontWeight.w400,
      ).copyWith(color: labelColor),
      labelSmall: const TextStyle(
        fontFamily: 'Viga',
        fontWeight: FontWeight.w400,
      ).copyWith(color: labelColor),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        primary: AppColors.primaryColor,
        onPrimary: AppColors.onPrimaryColor,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.onSecondaryColor,
        surface: AppColors.surfaceColorLight,
        onSurface: AppColors.onSurfaceColorLight,
        error: AppColors.errorColor,
        onError: AppColors.onErrorColor,
        brightness: Brightness.light,
      ),

      textTheme: _buildTextTheme(
        headingColor: AppColors.primaryColor,
        bodyColor: AppColors.onSurfaceColorLight,
        labelColor: AppColors.onSurfaceColorLight,
      ),

      scaffoldBackgroundColor: AppColors.backgroundColorLight,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        primary: AppColors.secondaryColor,
        onPrimary: AppColors.onSecondaryColor,
        secondary: AppColors.primaryColor,
        onSecondary: AppColors.onPrimaryColor,
        surface: AppColors.surfaceColorDark,
        onSurface: AppColors.onSurfaceColorDark,
        error: AppColors.errorColor,
        onError: AppColors.onErrorColor,
        brightness: Brightness.dark,
      ),
      textTheme: _buildTextTheme(
        headingColor: AppColors.primaryColor,
        bodyColor: AppColors.onSurfaceColorDark,
        labelColor: AppColors.onSurfaceColorDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColorDark,
    );
  }
}
