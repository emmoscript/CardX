import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../services/auth_service.dart';
import '../../main.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    
    // Check if user is authenticated
    if (authService.isAuthenticated) {
      return HomeScreen();
    }
    
    // Show AuthScreen if not authenticated
    return AuthScreen();
  }
} 