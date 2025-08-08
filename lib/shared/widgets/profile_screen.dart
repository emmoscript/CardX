import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/theme_service.dart';
import '../../core/services/hive_database_service.dart';
import '../../shared/models/user.dart';
import '../../main.dart';
import 'dart:math';
import '../../shared/models/card.dart' as card_model;
import '../../features/selling/item_detail_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String _selectedCurrency = 'USD';
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  List<card_model.Card> _myItems = [];
  bool _isLoadingItems = true;

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
    _loadMyItems();
  }

  Future<void> _loadMyItems() async {
    try {
      final database = HiveDatabaseService.instance;
      final allCards = await database.getAllCards();
      
      // Filter cards that start with 'item_' (user-created items)
      final myItems = allCards.where((card) => card.id.startsWith('item_')).toList();
      
      if (mounted) {
        setState(() {
          _myItems = myItems;
          _isLoadingItems = false;
        });
      }
    } catch (e) {
      print('Error loading my items: $e');
      if (mounted) {
        setState(() {
          _isLoadingItems = false;
        });
      }
    }
  }

  void _loadDarkMode() {
    final themeService = ref.read(themeServiceProvider);
    setState(() {
      _darkModeEnabled = themeService.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final themeService = ref.watch(themeServiceProvider);
    final user = authService.currentUser;
    
    // Sync local state with theme service
    _darkModeEnabled = themeService.isDarkMode;
    
    // Check if user is not authenticated
    if (user == null) {
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
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 24),
                Text(
                  'No tienes un perfil',
                  style: AppTypography.h4.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Para acceder a todas las funcionalidades del perfil, necesitas crear una cuenta.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/auth');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Crear Cuenta',
                    style: AppTypography.button.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/auth');
                  },
                  child: Text(
                    'Iniciar Sesión',
                    style: AppTypography.button.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
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
            
            // Quick Actions Section
            _buildQuickActionsSection(),
            SizedBox(height: 24),

            // My Items Section
            _buildMyItemsSection(),
            SizedBox(height: 24),

            // Premium Section
            _buildPremiumSection(),
            SizedBox(height: 24),
            
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

  Widget _buildQuickActionsSection() {
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
            'Acciones Rápidas',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Crear Subasta',
                  Icons.gavel,
                  AppColors.primary,
                  () => _showCreateAuctionDialog(),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Potenciar Perfil',
                  Icons.rocket_launch,
                  AppColors.warning,
                  () => _showSubscriptionDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTypography.body2.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
          
          // Debug Database (only in debug mode)
          _buildSettingItem(
            'Ver Base de Datos',
            'Debug',
            Icons.storage,
            () => _showDatabaseContents(),
          ),
          
          const Divider(color: AppColors.grey300),
          
          // Dark Mode
          _buildSwitchItem(
            'Modo oscuro',
            _darkModeEnabled,
            Icons.dark_mode,
            (value) {
              _toggleDarkMode();
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Editar Perfil',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'Usuario CardX'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'usuario@cardx.com'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ubicación',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'Santo Domingo, DO'),
            ),
          ],
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Perfil actualizado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Guardar',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Mi Wallet',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildWalletItem('Balance disponible', '\$1,250.00', Icons.account_balance_wallet, Colors.green),
            SizedBox(height: 12),
            _buildWalletItem('En subastas', '\$450.00', Icons.gavel, Colors.orange),
            SizedBox(height: 12),
            _buildWalletItem('Pendiente', '\$125.00', Icons.pending, Colors.blue),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showAddFundsDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Agregar fondos',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem(String title, String amount, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
                ),
                Text(
                  amount,
                  style: AppTypography.h6.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddFundsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Agregar Fondos',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Cantidad',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fondos agregados exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Agregar',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Métodos de Pago',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaymentMethodItem('💳', 'Visa ****1234', 'Principal'),
            SizedBox(height: 8),
            _buildPaymentMethodItem('🏦', 'Cuenta bancaria', 'Secundario'),
            SizedBox(height: 8),
            _buildPaymentMethodItem('📱', 'PayPal', 'Disponible'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Método de pago agregado'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Agregar método',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(String icon, String name, String status) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.body1.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  status,
                  style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  void _showTransactionHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Historial de Transacciones',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTransactionItem('Compra', 'Charizard Base Set', '\$299.99', 'Hoy', Colors.green),
              SizedBox(height: 8),
              _buildTransactionItem('Venta', 'Blue-Eyes White Dragon', '\$85.50', 'Ayer', Colors.blue),
              SizedBox(height: 8),
              _buildTransactionItem('Puja', 'Black Lotus Alpha', '\$15,000.00', 'Hace 2 días', Colors.orange),
              SizedBox(height: 8),
              _buildTransactionItem('Depósito', 'Fondos agregados', '\$500.00', 'Hace 1 semana', Colors.green),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String type, String description, String amount, String date, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            type == 'Compra' ? Icons.shopping_bag :
            type == 'Venta' ? Icons.sell :
            type == 'Puja' ? Icons.gavel :
            Icons.account_balance_wallet,
            color: color,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$type - $description',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date,
                  style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTypography.body1.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleDarkMode() {
    final themeService = ref.read(themeServiceProvider);
    themeService.toggleTheme();
    
    // Update local state
    setState(() {
      _darkModeEnabled = themeService.isDarkMode;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          themeService.isDarkMode ? 'Modo oscuro activado' : 'Modo claro activado'
        ),
        backgroundColor: AppColors.info,
      ),
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
      
      // Navegar a la pantalla de autenticación
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        (route) => false,
      );
    }
  }

  void _showDatabaseContents() async {
    try {
      final database = HiveDatabaseService.instance;
      await database.debugShowDatabaseContents();
      
      // Get actual data
      final users = await database.getAllUsers();
      final cards = await database.getAllCards();
      final auctions = await database.getAllAuctions();
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Contenido de la Base de Datos',
              style: AppTypography.h6.copyWith(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Usuarios (${users.length}):',
                    style: AppTypography.body1.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ...users.map((user) => Text('  • ${user.displayName} (${user.email})')),
                  const SizedBox(height: 16),
                  Text(
                    'Cartas (${cards.length}):',
                    style: AppTypography.body1.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ...cards.map((card) => Text('  • ${card.name} - \$${card.price}')),
                  const SizedBox(height: 16),
                  Text(
                    'Subastas (${auctions.length}):',
                    style: AppTypography.body1.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ...auctions.map((auction) => Text('  • ${auction.title} - \$${auction.currentPrice}')),
                ],
              ),
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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al mostrar base de datos: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showCreateAuctionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Crear Subasta',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Título de la Subasta',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'Mi Subasta'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: 'Descripción de la subasta'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Precio Inicial',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: '100.00'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Fecha de Finalización',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
              controller: TextEditingController(text: DateTime.now().add(Duration(days: 7)).toIso8601String()),
            ),
          ],
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subasta creada exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Crear Subasta',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Potenciar Perfil',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          '¿Quieres potenciar tu perfil para obtener más beneficios y acceso a características premium?',
          style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Perfil potenciado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Potenciar',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rocket_launch,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Suscripción Premium',
                style: AppTypography.h6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Desbloquea beneficios exclusivos y potencia tu experiencia',
            style: AppTypography.body2.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPremiumBenefit('✓', 'Sin comisiones'),
                    _buildPremiumBenefit('✓', 'Acceso prioritario'),
                    _buildPremiumBenefit('✓', 'Soporte 24/7'),
                  ],
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _showPremiumDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF1a1a2e),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Suscribirse',
                  style: AppTypography.body2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBenefit(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            icon,
            style: AppTypography.body2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body2.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPremiumDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Suscripción Premium',
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
              'Beneficios de la suscripción:',
              style: AppTypography.h6.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _buildBenefitItem('✓', 'Sin comisiones en transacciones'),
            _buildBenefitItem('✓', 'Acceso prioritario a subastas'),
            _buildBenefitItem('✓', 'Análisis de precios avanzado'),
            _buildBenefitItem('✓', 'Soporte prioritario 24/7'),
            _buildBenefitItem('✓', 'Alertas personalizadas'),
            SizedBox(height: 16),
            Text(
              'Precio: \$9.99/mes',
              style: AppTypography.h6.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
              _showPaymentDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Suscribirse',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            icon,
            style: AppTypography.body1.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Método de pago',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaymentOption('💳', 'Tarjeta de crédito/débito'),
            _buildPaymentOption('🏦', 'Transferencia bancaria'),
            _buildPaymentOption('📱', 'Pago móvil'),
          ],
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
              _processPayment(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Continuar',
              style: AppTypography.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String icon, String text) {
    return ListTile(
      leading: Text(icon, style: TextStyle(fontSize: 24)),
      title: Text(
        text,
        style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: () {
        // TODO: Implementar selección de método de pago
      },
    );
  }

  void _processPayment(BuildContext context) {
    // Simular procesamiento de pago
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16),
            Text(
              'Procesando pago...',
              style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );

    // Simular delay de procesamiento
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Cerrar diálogo de procesamiento
      
      // Mostrar confirmación
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            '¡Suscripción activada!',
            style: AppTypography.h5.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          content: Text(
            'Tu suscripción premium ha sido activada exitosamente. Disfruta de todos los beneficios.',
            style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                '¡Perfecto!',
                style: AppTypography.body1.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMyItemsSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mis Items',
                style: AppTypography.h6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                onPressed: _loadMyItems,
                icon: Icon(Icons.refresh, color: AppColors.primary),
                tooltip: 'Refrescar',
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_isLoadingItems)
            Center(child: CircularProgressIndicator())
          else if (_myItems.isEmpty)
            Column(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 48,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 8),
                Text(
                  'No tienes items publicados a la venta.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  '${_myItems.length} item${_myItems.length == 1 ? '' : 's'} publicado${_myItems.length == 1 ? '' : 's'}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _myItems.length,
                  itemBuilder: (context, index) {
                    final card = _myItems[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getGameColor(card.game).withOpacity(0.1),
                          child: Icon(
                            Icons.shopping_bag,
                            color: _getGameColor(card.game),
                            size: 20,
                          ),
                        ),
                        title: Text(
                          card.name,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${card.game.shortName} • ${card.condition?.displayName ?? 'N/A'}',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              'Precio: \$${card.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.buyGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ItemDetailScreen(item: card),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/sell-item');
                // Refresh items when returning from sell screen
                _loadMyItems();
              },
              icon: Icon(Icons.add),
              label: Text('Vender Item'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getGameColor(card_model.CardGame game) {
    switch (game) {
      case card_model.CardGame.pokemon:
        return AppColors.pokemon;
      case card_model.CardGame.yugioh:
        return AppColors.yugioh;
      case card_model.CardGame.mtg:
        return AppColors.primary;
      case card_model.CardGame.onePiece:
        return AppColors.onePiece;
      case card_model.CardGame.dragonBall:
        return AppColors.dragonBall;
      case card_model.CardGame.digimon:
        return AppColors.digimon;
      case card_model.CardGame.gundam:
        return AppColors.gundam;
      case card_model.CardGame.starWarsUnlimited:
        return AppColors.starWarsUnlimited;
      default:
        return AppColors.primary;
    }
  }
} 