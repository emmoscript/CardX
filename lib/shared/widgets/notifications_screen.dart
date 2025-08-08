import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushNotificationsEnabled = false;
  bool _priceAlertsEnabled = true;
  bool _auctionAlertsEnabled = true;
  bool _messageAlertsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              // Hero Section
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4CAF50),
                      Color(0xFF388E3C),
                      Color(0xFF2E7D32),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Mantente Informado',
                      style: AppTypography.h4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Recibe notificaciones sobre precios, subastas, mensajes y más',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Push Notifications Toggle
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notificaciones Push',
                            style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Recibe notificaciones en tiempo real',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _pushNotificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _pushNotificationsEnabled = value;
                        });
                        if (value) {
                          _showEnableNotificationsDialog();
                        }
                      },
                      activeColor: AppColors.primary,
                    ),
                  ],
                ),
              ),

              // Notification Types
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Tipos de Notificaciones',
                  style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              _buildNotificationType(
                'Alertas de Precio',
                'Notificaciones cuando los precios de tus cartas favoritas cambien',
                Icons.trending_up,
                _priceAlertsEnabled,
                (value) => setState(() => _priceAlertsEnabled = value),
              ),

              _buildNotificationType(
                'Subastas',
                'Notificaciones sobre nuevas subastas y actualizaciones',
                Icons.gavel,
                _auctionAlertsEnabled,
                (value) => setState(() => _auctionAlertsEnabled = value),
              ),

              _buildNotificationType(
                'Mensajes',
                'Notificaciones de mensajes de otros usuarios',
                Icons.message,
                _messageAlertsEnabled,
                (value) => setState(() => _messageAlertsEnabled = value),
              ),

              // Recent Notifications
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Notificaciones Recientes',
                  style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              _buildNotificationItem(
                'Precio actualizado',
                'El precio de "Charizard" ha cambiado de \$299.99 a \$325.00',
                'Hace 2 horas',
                Icons.trending_up,
                AppColors.buyGreen,
              ),

              _buildNotificationItem(
                'Nueva subasta',
                'Se ha iniciado una nueva subasta de Pokémon',
                'Hace 4 horas',
                Icons.gavel,
                AppColors.primary,
              ),

              _buildNotificationItem(
                'Mensaje nuevo',
                'Usuario123 te ha enviado un mensaje sobre "Blue-Eyes White Dragon"',
                'Hace 6 horas',
                Icons.message,
                AppColors.grey600,
              ),

              _buildNotificationItem(
                'Oferta recibida',
                'Has recibido una oferta de \$45.00 por "Dark Magician"',
                'Hace 1 día',
                Icons.local_offer,
                AppColors.buyGreen,
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationType(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
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

  Widget _buildNotificationItem(String title, String message, String time, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: AppTypography.labelSmall.copyWith(color: AppColors.grey400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEnableNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Activar Notificaciones'),
        content: Text(
          'Para recibir notificaciones push, necesitas permitir que CardX te envíe notificaciones. ¿Quieres activarlas ahora?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Más tarde'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement notification permission request
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notificaciones activadas')),
              );
            },
            child: Text('Activar'),
          ),
        ],
      ),
    );
  }
} 