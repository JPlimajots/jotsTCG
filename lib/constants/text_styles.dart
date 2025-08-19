import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

abstract class AppTextStyles {
  // Títulos Principais
  static TextStyle get headLineLarge {
    return GoogleFonts.merriweather(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }
  static TextStyle get headLineMedium {
    return GoogleFonts.merriweather(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }
  static TextStyle get headLineSmall {
    return GoogleFonts.merriweather(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );
  }

  // Corpo de Texto
  static TextStyle get bodyLarge {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }
  static TextStyle get bodyMedium {
    return GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    );
  }

  // Botões
  static TextStyle get button {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  // Nome das Cartas
  static TextStyle get cardTitle {
    return GoogleFonts.merriweather(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  // Input
  static TextStyle get inputText {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }
}
