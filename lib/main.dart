import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_typography.dart';
import 'core/services/hive_database_service.dart';
import 'core/services/seed_data_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/theme_service.dart';
import 'core/widgets/auth_wrapper.dart';
import 'features/auctions/auctions_screen.dart';
import 'shared/widgets/search_screen.dart';
import 'shared/widgets/favorites_screen.dart';
import 'shared/widgets/profile_screen.dart';
import 'shared/widgets/splash_screen.dart';
import 'features/selling/sell_item_screen.dart';
import 'dart:async';

// Provider for AuthService
final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService();
});

// Provider for ThemeService
final themeServiceProvider = ChangeNotifierProvider<ThemeService>((ref) {
  return ThemeService();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (temporarily disabled)
  // await Firebase.initializeApp();
  
  // Initialize Hive database
  await HiveDatabaseService.instance.initialize();
  
  // Seed database with sample data if empty
  final isEmpty = await SeedDataService.isDatabaseEmpty();
  if (isEmpty) {
    await SeedDataService.seedDatabase();
  }

  await Hive.initFlutter();
  // Open Hive boxes
  await Hive.openBox('userBox');
  await Hive.openBox('usersBox');
  await Hive.openBox('themeBox');
  await Hive.openBox('collectionsBox');
  await Hive.openBox('cartBox');
  await Hive.openBox('messagesBox');
  
  runApp(const ProviderScope(child: CardXApp()));
}

class CardXApp extends ConsumerWidget {
  const CardXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeService = ref.watch(themeServiceProvider);
    
    return MaterialApp(
      title: 'CardX',
      debugShowCheckedModeBanner: false,
      theme: themeService.currentTheme,
      home: SplashScreen(),
      routes: {
        '/auth': (context) => AuthWrapper(),
        '/auctions': (context) => const AuctionsScreen(),
        '/search': (context) => SearchScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/profile': (context) => ProfileScreen(),
        '/sell-item': (context) => SellItemScreen(),
      },
    );
  }
}
