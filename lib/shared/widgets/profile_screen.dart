import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/auth_service.dart';
import '../../main.dart';
import 'dart:math';
import 'package:hive/hive.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String _selectedCurrency = 'USD';
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final user = authService.currentUser;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Mi Perfil',
          style: AppTypography.h4.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.textPrimary),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(user),
            const SizedBox(height: 24),
            
            // Stats Section
            _buildStatsSection(),
            const SizedBox(height: 24),
            
            // Activity Section
            _buildActivitySection(),
            const SizedBox(height: 24),
            
            // Settings Section
            _buildSettingsSection(),
            const SizedBox(height: 24),
            
            // Account Section
            _buildAccountSection(authService),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User? user) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            child: Text(
              user?.displayName?.isNotEmpty == true 
                  ? user!.displayName![0].toUpperCase()
                  : 'U',
              style: AppTypography.h3.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // User Info
          Text(
            user?.displayName ?? 'Usuario',
            style: AppTypography.h5.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? 'usuario@example.com',
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Edit Profile Button
          OutlinedButton(
            onPressed: _editProfile,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Editar perfil',
              style: AppTypography.body1.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Compras', '12', Icons.shopping_bag),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildStatCard('Ventas', '8', Icons.store),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildStatCard('Favoritos', '24', Icons.favorite),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actividad reciente',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem('Compra realizada', 'Charizard Base Set', '\$299.99', Icons.shopping_bag),
          const Divider(color: AppColors.grey300),
          _buildActivityItem('Subasta creada', 'Blue-Eyes White Dragon', '\$25.99', Icons.gavel),
          const Divider(color: AppColors.grey300),
          _buildActivityItem('Puja realizada', 'Black Lotus Alpha', '\$50000.00', Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String action, String item, String price, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: AppTypography.body2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  item,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: AppTypography.body2.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Configuración',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Currency
          _buildSettingItem(
            'Moneda',
            _selectedCurrency,
            Icons.attach_money,
            () => _showCurrencyDialog(),
          ),
          
          const Divider(color: AppColors.grey300),
          
          // Notifications
          _buildSwitchItem(
            'Notificaciones',
            _notificationsEnabled,
            Icons.notifications,
            (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          
          const Divider(color: AppColors.grey300),
          
          // Dark Mode
          _buildSwitchItem(
            'Modo oscuro',
            _darkModeEnabled,
            Icons.dark_mode,
            (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String value, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                title,
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              value,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String title, bool value, IconData icon, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              title,
              style: AppTypography.body1.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(AuthService authService) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cuenta',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildAccountItem('Mi wallet', Icons.account_balance_wallet, _showWallet),
          const Divider(color: AppColors.grey300),
          _buildAccountItem('Métodos de pago', Icons.credit_card, _showPaymentMethods),
          const Divider(color: AppColors.grey300),
          _buildAccountItem('Historial de transacciones', Icons.history, _showTransactionHistory),
          const Divider(color: AppColors.grey300),
          _buildAccountItem('Acerca de', Icons.info, _showAbout),
          const Divider(color: AppColors.grey300),
          _buildAccountItem('Cerrar sesión', Icons.logout, () => _showLogoutDialog(authService)),
        ],
      ),
    );
  }

  Widget _buildAccountItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                title,
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    // TODO: Implementar edición de perfil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de edición próximamente')),
    );
  }

  void _showSettings() {
    // TODO: Implementar configuración avanzada
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración avanzada')),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar moneda',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCurrencyOption('USD', 'Dólar estadounidense'),
            _buildCurrencyOption('EUR', 'Euro'),
            _buildCurrencyOption('MXN', 'Peso mexicano'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyOption(String currency, String description) {
    return ListTile(
      title: Text(currency),
      subtitle: Text(description),
      trailing: _selectedCurrency == currency ? Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        setState(() {
          _selectedCurrency = currency;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showWallet() {
    // TODO: Implementar wallet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallet próximamente')),
    );
  }

  void _showPaymentMethods() {
    // TODO: Implementar métodos de pago
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Métodos de pago próximamente')),
    );
  }

  void _showTransactionHistory() {
    // TODO: Implementar historial
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Historial próximamente')),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Acerca de CardX',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Versión: 1.0.0',
              style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'CardX es la plataforma líder para el trading de cartas coleccionables.',
              style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: AppTypography.body1.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cerrar sesión',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          '¿Estás seguro de que quieres cerrar sesión?',
          style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _logout(authService);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Cerrar sesión',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(AuthService authService) async {
    await authService.signOut();
    
    // Limpiar datos de usuario en Hive
    final userBox = Hive.box('userBox');
    await userBox.clear();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sesión cerrada exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
} 