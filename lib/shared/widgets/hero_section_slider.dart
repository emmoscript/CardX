import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import 'dart:math';

class HeroSectionSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final slides = [
      _HeroSlide(
        image: 'assets/images/hero1.png',
        title: 'Compra, Vende de forma segura y confiable',
        subtitle: '¡Regístrate gratis y empieza hoy mismo!',
        actions: [
          _HeroButton(
            text: 'Comprar', 
            onPressed: () => _navigateToSearch(context),
            gradientColors: [
              Color(0xFF4CAF50),
              Color(0xFF388E3C),
              Color(0xFF2E7D32),
            ],
          ),
          _HeroButton(
            text: 'Vender ahora', 
            primary: true, 
            onPressed: () => _navigateToCreateAuction(context),
            gradientColors: [
              Color(0xFF4CAF50),
              Color(0xFF388E3C),
              Color(0xFF2E7D32),
            ],
          ),
        ],
        gradient: [
          Color(0xFF4CAF50),
          Color(0xFF388E3C),
          Color(0xFF2E7D32),
        ],
      ),
      _HeroSlide(
        image: 'assets/images/hero2.png',
        title: '¡Subasta tus cartas favoritas!',
        subtitle: 'Participa en subastas exclusivas de TCG',
        actions: [
          _HeroButton(
            text: 'Ver subastas', 
            primary: true, 
            onPressed: () => _navigateToAuctions(context),
            gradientColors: [
              Color(0xFFFF9800),
              Color(0xFFF57C00),
              Color(0xFFE65100),
            ],
          ),
        ],
        gradient: [
          Color(0xFFFF9800),
          Color(0xFFF57C00),
          Color(0xFFE65100),
        ],
      ),
      _HeroSlide(
        image: 'assets/images/hero3.png',
        title: 'Publica singles de cualquier carta',
        subtitle: 'Pokémon, One Piece, Magic, Yu-Gi-Oh! y más',
        actions: [
          _HeroButton(
            text: 'Comprar', 
            onPressed: () => _navigateToSearch(context),
            gradientColors: [
              Color(0xFF2196F3),
              Color(0xFF1976D2),
              Color(0xFF0D47A1),
            ],
          ),
          _HeroButton(
            text: 'Vender ahora', 
            primary: true, 
            onPressed: () => _navigateToCreateAuction(context),
            gradientColors: [
              Color(0xFF2196F3),
              Color(0xFF1976D2),
              Color(0xFF0D47A1),
            ],
          ),
        ],
        gradient: [
          Color(0xFF2196F3),
          Color(0xFF1976D2),
          Color(0xFF0D47A1),
        ],
      ),
      _HeroSlide(
        image: '',
        title: 'Potencia tu perfil',
        subtitle: 'Suscríbete y obtén beneficios exclusivos',
        actions: [
          _HeroButton(
            text: 'Suscribirse', 
            primary: true, 
            onPressed: () => _showSubscriptionDialog(context),
            gradientColors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ],
        gradient: [
          Color(0xFF1a1a2e),
          Color(0xFF16213e),
          Color(0xFF0f3460),
        ],
        hasStars: true,
        specialIcon: Icons.rocket_launch,
        showOnlyIcon: true,
      ),
      _HeroSlide(
        image: 'assets/images/hero5.png',
        title: '¡Explora el mundo del TCG!',
        subtitle: 'Descubre cartas, accesorios y más',
        actions: [
          _HeroButton(
            text: 'Explorar', 
            onPressed: () => _navigateToSearch(context),
            gradientColors: [
              Color(0xFF9C27B0),
              Color(0xFF7B1FA2),
              Color(0xFF4A148C),
            ],
          ),
        ],
        gradient: [
          Color(0xFF9C27B0),
          Color(0xFF7B1FA2),
          Color(0xFF4A148C),
        ],
      ),
    ];
    return SizedBox(
      height: 290,
      child: PageView.builder(
        itemCount: slides.length,
        controller: PageController(viewportFraction: 0.92),
        itemBuilder: (context, index) => slides[index],
      ),
    );
  }
}

class _HeroSlide extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final List<Color> gradient;
  final bool hasStars;
  final IconData? specialIcon;
  final bool showOnlyIcon;
  
  const _HeroSlide({
    required this.image, 
    required this.title, 
    required this.subtitle, 
    required this.actions,
    required this.gradient,
    this.hasStars = false,
    this.specialIcon,
    this.showOnlyIcon = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Estrellas de fondo (solo para el slide de perfil)
              if (hasStars)
                Positioned.fill(
                  child: CustomPaint(
                    painter: StarsPainter(),
                  ),
                ),
              // Contenido principal
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 180),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300),
                            child: Text(
                              title,
                              style: AppTypography.h4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300),
                            child: Text(
                              subtitle,
                              style: AppTypography.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 16),
                          actions.length == 2
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(child: actions[0]),
                                  SizedBox(width: 8),
                                  Flexible(child: actions[1]),
                                ],
                              )
                            : actions.length == 1
                              ? actions[0]
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Flexible(
                      flex: 1,
                      child: Stack(
                        children: [
                          if (specialIcon != null && showOnlyIcon)
                            Center(
                              child: Icon(
                                specialIcon,
                                size: 70,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeroButton extends StatelessWidget {
  final String text;
  final bool primary;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  
  const _HeroButton({
    required this.text, 
    this.primary = false, 
    this.onPressed,
    this.gradientColors,
  });
  
  @override
  Widget build(BuildContext context) {
    Color buttonTextColor = primary && gradientColors != null 
      ? gradientColors!.first 
      : (primary ? AppColors.primary : Colors.white);
    
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(120, 44),
          maximumSize: Size(160, 44),
          backgroundColor: primary ? Colors.white : Colors.white.withOpacity(0.2),
          foregroundColor: buttonTextColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: AppTypography.labelLarge.copyWith(fontSize: 15),
        ),
        onPressed: onPressed,
        child: FittedBox(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ),
    );
  }
}

class StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final random = Random(42); // Seed fijo para estrellas consistentes
    
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.2 + 0.3;
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Navigation functions
void _navigateToSearch(BuildContext context) {
  // Navigate to search tab
  Navigator.of(context).pushNamed('/search');
}

void _navigateToAuctions(BuildContext context) {
  // Navigate to auctions tab
  Navigator.of(context).pushNamed('/auctions');
}

void _navigateToCreateAuction(BuildContext context) {
  // Navigate to profile screen for selling
  Navigator.of(context).pushNamed('/profile');
}

void _navigateToProfile(BuildContext context) {
  // Navigate to profile screen for selling
  Navigator.of(context).pushNamed('/profile');
}

void _showSubscriptionDialog(BuildContext context) {
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
          const SizedBox(height: 12),
          _buildBenefitItem('✓', 'Sin comisiones en transacciones'),
          _buildBenefitItem('✓', 'Acceso prioritario a subastas'),
          _buildBenefitItem('✓', 'Análisis de precios avanzado'),
          _buildBenefitItem('✓', 'Soporte prioritario 24/7'),
          _buildBenefitItem('✓', 'Alertas personalizadas'),
          const SizedBox(height: 16),
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
        const SizedBox(width: 8),
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
          const SizedBox(height: 16),
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