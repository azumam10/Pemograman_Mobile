import 'package:flutter/material.dart';

/// Palet warna DesaKu: ungu (sesuai referensi UI) + marun & emas (sentuhan batik).
class AppColors {
  static const purple = Color(0xFF4A1D6B);
  static const purpleDark = Color(0xFF341050);
  static const purpleSoft = Color(0xFFF1E8F8);
  static const maroon = Color(0xFF6E1423);
  static const gold = Color(0xFFD9A441);
  static const goldLight = Color(0xFFF4DFA8);
  static const background = Color(0xFFF8F5FB);
  static const surface = Colors.white;
  static const text = Color(0xFF241A2E);
  static const textMuted = Color(0xFF5E5368);
  static const border = Color(0xFFE3D9EC);
  static const success = Color(0xFF1E8E5A);
  static const danger = Color(0xFFC62B3B);
  static const info = Color(0xFF2F6FB5);
  static const warning = Color(0xFFB27A00);
  static const orange = Color(0xFFD2691E);
}

class AppAssets {
  static const batik1 = 'assets/batik/pola_batik1.jpg';
  static const batik2 = 'assets/batik/pola_batik2.jpg';
}

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.purple,
    primary: AppColors.purple,
    secondary: AppColors.gold,
    surface: AppColors.surface,
    error: AppColors.danger,
  );

  OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: c, width: w),
  );

  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    colorScheme: scheme,
    // NFR-07: ukuran teks minimal 16 sp.
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 16),
      labelMedium: TextStyle(fontSize: 16),
      labelSmall: TextStyle(fontSize: 16),
      titleMedium: TextStyle(fontSize: 16),
      titleSmall: TextStyle(fontSize: 16),
    ).apply(bodyColor: AppColors.text, displayColor: AppColors.text),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.text,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.purpleSoft.withValues(alpha: 0.45),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 16),
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.purple, 1.6),
      errorBorder: border(AppColors.danger),
      focusedErrorBorder: border(AppColors.danger, 1.6),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: const BorderSide(color: AppColors.border),
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.purpleDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );
}
