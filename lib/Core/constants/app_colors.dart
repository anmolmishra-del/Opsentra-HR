import 'package:flutter/material.dart';

class AppColors {
  // 🔷 Primary Brand Colors (Royal Blue)
  static const Color primary = Color(0xFF1F4ED8);        // Main brand color
  static const Color primaryDark = Color(0xFF163A9F);    // Dark blue
  static const Color primaryLight = Color(0xFF3B6CF0);   // Light blue

  // 🔷 Gradient Colors
  static const Color gradientStart = Color(0xFF1F4ED8);
  static const Color gradientEnd = Color(0xFF3B6CF0);

  // ⚪ Background & Surface
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF5F7FB);
  static const Color lightGrey = Color(0xFFE0E6F0);
  static const Color grey = Color(0xFF9AA4B2);

  // 📝 Text Colors
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textMedium = Color(0xFF5F6C85);
  static const Color textLight = Color(0xFF9AA4B2);

  // ⚫ Basic
  static const Color black = Color(0xFF000000);

  // 🟢🟡🔴 Status Colors
  static const Color success = Color(0xFF2ECC71); // Present / Paid
  static const Color warning = Color(0xFFF39C12); // Pending
  static const Color error = Color(0xFFE74C3C);   // Rejected / Error
  static const Color info = Color(0xFF3498DB);    // Info / Holiday
}
