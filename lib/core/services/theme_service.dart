import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../constants/app_colors.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeBoxName = 'themeBox';
  static const String _isDarkModeKey = 'isDarkMode';
  
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  ThemeService() {
    _loadThemePreference();
  }
  
  Future<void> _loadThemePreference() async {
    try {
      final box = Hive.box(_themeBoxName);
      _isDarkMode = box.get(_isDarkModeKey, defaultValue: false);
      notifyListeners();
    } catch (e) {
      print('Error loading theme preference: $e');
      // If there's an error, default to light mode
      _isDarkMode = false;
      notifyListeners();
    }
  }
  
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveThemePreference();
    notifyListeners();
  }
  
  Future<void> _saveThemePreference() async {
    try {
      final box = Hive.box(_themeBoxName);
      await box.put(_isDarkModeKey, _isDarkMode);
    } catch (e) {
      print('Error saving theme preference: $e');
    }
  }
  
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: AppColors.textPrimary),
        headlineMedium: TextStyle(color: AppColors.textPrimary),
        headlineSmall: TextStyle(color: AppColors.textPrimary),
        titleLarge: TextStyle(color: AppColors.textPrimary),
        titleMedium: TextStyle(color: AppColors.textPrimary),
        titleSmall: TextStyle(color: AppColors.textPrimary),
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textPrimary),
        bodySmall: TextStyle(color: AppColors.textSecondary),
        labelLarge: TextStyle(color: AppColors.textPrimary),
        labelMedium: TextStyle(color: AppColors.textPrimary),
        labelSmall: TextStyle(color: AppColors.textSecondary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey400,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: TextStyle(color: AppColors.textPrimary),
        hintStyle: TextStyle(color: AppColors.textSecondary),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.border,
      ),
      iconTheme: IconThemeData(
        color: AppColors.textPrimary,
      ),
    );
  }
  
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        onBackground: AppColors.darkTextPrimary,
        error: AppColors.darkError,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: AppColors.darkTextPrimary),
        headlineMedium: TextStyle(color: AppColors.darkTextPrimary),
        headlineSmall: TextStyle(color: AppColors.darkTextPrimary),
        titleLarge: TextStyle(color: AppColors.darkTextPrimary),
        titleMedium: TextStyle(color: AppColors.darkTextPrimary),
        titleSmall: TextStyle(color: AppColors.darkTextPrimary),
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
        bodySmall: TextStyle(color: AppColors.darkTextSecondary),
        labelLarge: TextStyle(color: AppColors.darkTextPrimary),
        labelMedium: TextStyle(color: AppColors.darkTextPrimary),
        labelSmall: TextStyle(color: AppColors.darkTextSecondary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: TextStyle(color: AppColors.darkTextPrimary),
        hintStyle: TextStyle(color: AppColors.darkTextSecondary),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.darkBorder,
      ),
      iconTheme: IconThemeData(
        color: AppColors.darkTextPrimary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkCard,
        labelStyle: TextStyle(color: AppColors.darkTextPrimary),
        secondaryLabelStyle: TextStyle(color: AppColors.darkTextSecondary),
        selectedColor: AppColors.primary,
        disabledColor: AppColors.darkGrey300,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkCard,
        titleTextStyle: TextStyle(color: AppColors.darkTextPrimary),
        contentTextStyle: TextStyle(color: AppColors.darkTextSecondary),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkCard,
        contentTextStyle: TextStyle(color: AppColors.darkTextPrimary),
        actionTextColor: AppColors.primary,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: TextStyle(color: AppColors.darkTextPrimary),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.darkCard,
        textStyle: TextStyle(color: AppColors.darkTextPrimary),
      ),
    );
  }
  
  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;
}