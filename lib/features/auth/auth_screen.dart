import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/auth_service.dart';
import '../../features/home/home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLogin = true;

  void _switchToRegister() {
    setState(() {
      _isLogin = false;
    });
  }

  void _switchToLogin() {
    setState(() {
      _isLogin = true;
    });
  }

  void _continueWithoutAuth() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin
        ? LoginScreen(
            onSwitchToRegister: _switchToRegister,
            onContinueWithoutAuth: _continueWithoutAuth,
          )
        : RegisterScreen(
            onSwitchToLogin: _switchToLogin,
            onContinueWithoutAuth: _continueWithoutAuth,
          );
  }
} 