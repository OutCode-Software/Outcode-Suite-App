import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../base/constants/app_text_styles.dart';
import '../base/utils/colors.dart';

class AppTheme {
  final accentColor1 = AppColors.accent1Light;

  ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLight,
      textTheme: getTextTheme(AppColors.primaryTextLight),
      scaffoldBackgroundColor: AppColors.primaryBackgroundLight,
      fontFamily: GoogleFonts.adamina().fontFamily,
      iconTheme: const IconThemeData(color: AppColors.primaryTextLight),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryLight,
          unselectedItemColor: AppColors.secondaryTextLight.withOpacity(0.8),
          selectedIconTheme:
              const IconThemeData(color: AppColors.primaryTextLight)),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryLight,
          onPrimary: AppColors.primaryTextLight,
          secondary: AppColors.secondaryLight,
          onSecondary: AppColors.secondaryTextLight,
          error: AppColors.errorLight,
          onError: AppColors.white,
          background: AppColors.primaryBackgroundLight,
          onBackground: AppColors.primaryTextLight,
          surface: AppColors.secondaryBackgroundLight,
          onSurface: AppColors.secondaryTextLight,
          shadow: AppColors.accent2Light),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
      ));

  ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      textTheme: getTextTheme(AppColors.primaryTextDark),
      scaffoldBackgroundColor: AppColors.primaryBackgroundDark,
      fontFamily: GoogleFonts.barlow().fontFamily,
      iconTheme: const IconThemeData(color: AppColors.primaryTextDark),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: AppColors.secondaryTextDark.withOpacity(0.8),
          selectedIconTheme:
              const IconThemeData(color: AppColors.primaryTextDark)),
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryDark,
          onPrimary: AppColors.primaryTextDark,
          secondary: AppColors.secondaryDark,
          onSecondary: AppColors.secondaryTextDark,
          error: AppColors.errorDark,
          onError: AppColors.white,
          background: AppColors.primaryBackgroundDark,
          onBackground: AppColors.primaryTextDark,
          surface: AppColors.secondaryBackgroundDark,
          onSurface: AppColors.secondaryTextDark,
          shadow: AppColors.accent2Dark),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark));

  ThemeData getCurrentTheme(BuildContext context) {
    return darkTheme;
  }

  TextTheme getTextTheme(Color color) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: color),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: color),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: color),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: color),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: color),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: color),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: color),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: color),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: color),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: color),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: color),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: color),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: color),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: color),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: color),
    );
  }
}
