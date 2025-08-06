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
          _HeroButton(text: 'Comprar'),
          _HeroButton(text: 'Vender ahora', primary: true),
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
          _HeroButton(text: 'Ver subastas', primary: true),
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
          _HeroButton(text: 'Comprar'),
          _HeroButton(text: 'Vender ahora', primary: true),
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
          _HeroButton(text: 'Suscribirse', primary: true),
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
          _HeroButton(text: 'Explorar'),
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
                            constraints: BoxConstraints(maxWidth: 260),
                            child: Text(
                              title,
                              style: AppTypography.h4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 260),
                            child: Text(
                              subtitle,
                              style: AppTypography.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              maxLines: 2,
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
  const _HeroButton({required this.text, this.primary = false});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(120, 44),
          maximumSize: Size(160, 44),
          backgroundColor: primary ? Colors.white : Colors.white.withOpacity(0.2),
          foregroundColor: primary ? AppColors.primary : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: AppTypography.labelLarge.copyWith(fontSize: 15),
        ),
        onPressed: () {},
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