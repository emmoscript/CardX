import 'package:flutter/material.dart';

class AppColors {
  // Colores primarios
  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF1A1A1A);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F8F8);
  
  // Grises
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  
  // Acentos
  static const Color accent = Color(0xFF00C853); // Verde para compras
  static const Color accentLight = Color(0xFF69F0AE);
  static const Color accentDark = Color(0xFF00E676);
  
  // Estados
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Trading específicos
  static const Color buyGreen = Color(0xFF00C853);
  static const Color sellRed = Color(0xFFD32F2F);
  static const Color tradeBlue = Color(0xFF1976D2);
  
  // Texto
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textInverse = Color(0xFFFFFFFF);
  
  // Bordes y divisores
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
  
  // Sombras
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
} 