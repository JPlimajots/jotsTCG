import 'package:flutter/material.dart';

abstract class AppColors {
  // Cores Principais
  static const Color primary = Color(0xFFCD7F32); // Bronze
  static const Color accent = Color(0xFF2E8B57); // Verde esmeralda

  // Fundo
  static const Color background = Color(0xFF2A1A1F); // Marrom escuro
  static const Color surface = Color(0xFF4D3F38); // Pergaminho escuro

  // Texto
  static const Color textPrimary = Color(0xFFF5EFE6); // Creme
  static const Color textSecondary = Color(0xFFAE9B90); // Cinza quente

  // Feedback
  static const Color success = Color(0xFF556B2F); // Verde musgo
  static const Color warning = Color(0xFFFFBF00); // Âmbar
  static const Color error = Color(0xFFB22222); // Vermelho ferrugem

  // Raridade
  static const Color rarityCommon = Color(0xFF848482); // Cinza pedra
  static const Color rarityRare = Color(0xFFC0C0C0); // Prata
  static const Color rarityEpic = Color(0xFF2E8B57); // Verde esmeralda
  static const Color rarityLegendary = Color(0xFFCD7F32); // Bronze

  // Efeitos Visuais
  static const Gradient primaryGradient = LinearGradient(
    colors: <Color>[primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x4D000000),
    blurRadius: 10,
    offset: Offset(0, 5),
  );
}
