import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../features/auth/auth_screen.dart';

class AuthRequiredWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onAuthSuccess;

  const AuthRequiredWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    this.onAuthSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: AppColors.grey300, width: 2),
                ),
                child: Icon(
                  icon,
                  size: 60,
                  color: AppColors.grey600,
                ),
              ),
              
              SizedBox(height: AppSpacing.xl),
              
              // Título
              Text(
                title,
                style: AppTypography.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: AppSpacing.md),
              
              // Mensaje
              Text(
                message,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: AppSpacing.xl),
              
              // Botón de iniciar sesión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _navigateToAuth(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Iniciar Sesión',
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: AppSpacing.md),
              
              // Botón de registrarse
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _navigateToAuth(context, isRegister: true),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: BorderSide(color: AppColors.grey300),
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Crear Cuenta',
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: AppSpacing.lg),
              
              // Texto informativo
              Text(
                'Necesitas una cuenta para acceder a esta funcionalidad',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAuth(BuildContext context, {bool isRegister = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AuthScreen(),
      ),
    ).then((_) {
      // Si el usuario se autenticó exitosamente y hay un callback
      if (FirebaseAuth.instance.currentUser != null && onAuthSuccess != null) {
        onAuthSuccess!();
      }
    });
  }
}

// Widget específico para Favoritos
class FavoritesAuthRequired extends StatelessWidget {
  const FavoritesAuthRequired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthRequiredWidget(
      title: 'Favoritos',
      message: 'Guarda tus cartas favoritas para acceder rápidamente a ellas y recibir notificaciones de cambios de precio.',
      icon: Icons.favorite_outline,
    );
  }
}

// Widget específico para Perfil
class ProfileAuthRequired extends StatelessWidget {
  const ProfileAuthRequired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthRequiredWidget(
      title: 'Perfil',
      message: 'Accede a tu perfil personalizado, configura tus preferencias y gestiona tu cuenta.',
      icon: Icons.person_outline,
    );
  }
}

// Widget específico para Compras
class PurchaseAuthRequired extends StatelessWidget {
  const PurchaseAuthRequired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthRequiredWidget(
      title: 'Compras',
      message: 'Necesitas una cuenta para realizar compras y gestionar tus pedidos.',
      icon: Icons.shopping_cart_outlined,
    );
  }
} 