import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_typography.dart';
import 'core/services/database_helper.dart';
import 'core/services/seed_data_service.dart';
import 'core/services/auth_service.dart';
import 'core/widgets/auth_wrapper.dart';
import 'dart:async';

// Provider for AuthService
final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (temporarily disabled)
  // await Firebase.initializeApp();
  
  // Initialize database
  await DatabaseHelper.instance.database;
  
  // Seed database with sample data if empty
  final isEmpty = await SeedDataService.isDatabaseEmpty();
  if (isEmpty) {
    await SeedDataService.seedDatabase();
  }

  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Hive.openBox('usersBox');
  
  runApp(const ProviderScope(child: CardXApp()));
}

class CardXApp extends StatelessWidget {
  const CardXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CardX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: AppTypography.h1,
          displayMedium: AppTypography.h2,
          displaySmall: AppTypography.h3,
          headlineMedium: AppTypography.h4,
          headlineSmall: AppTypography.h5,
          titleLarge: AppTypography.h6,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.h4.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textInverse,
            textStyle: AppTypography.button,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
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
            borderSide: BorderSide(color: AppColors.accent, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        cardTheme: CardThemeData(
          color: AppColors.background,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: AuthWrapper(),
    );
  }
}
