import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';

class AuctionSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> auctions = [
      {
        'image': 'assets/images/pokemon_auction.png',
        'title': 'Subasta N°15 Pokémon',
        'date': '26/06 - 03/07',
        'status': 'DISPONIBLE',
        'statusColor': AppColors.buyGreen,
      },
      {
        'image': 'assets/images/yugioh_auction.png',
        'title': 'Subasta N°16 Yu-Gi-Oh!',
        'date': '09/07 - 16/07',
        'status': 'PRÓXIMAMENTE',
        'statusColor': AppColors.grey400,
      },
      {
        'image': 'assets/images/magic_auction.png',
        'title': 'Subasta N°17 Magic',
        'date': '30/07 - 06/08',
        'status': 'PRÓXIMAMENTE',
        'statusColor': AppColors.grey400,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Subastas', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/auctions');
                },
                child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: auctions.length,
            separatorBuilder: (_, __) => SizedBox(width: 16),
            itemBuilder: (context, index) {
              final auction = auctions[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to specific auction
                  Navigator.of(context).pushNamed('/auctions');
                },
                child: Container(
                  width: 200,
                  height: 160,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight.withOpacity(0.10),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Imagen de fondo
                      Positioned.fill(
                        child: Image.asset(
                          auction['image'] as String,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.grey100,
                            child: Icon(Icons.image, size: 40, color: AppColors.grey400),
                          ),
                        ),
                      ),
                      // Degradado negro
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.55),
                                Colors.black.withOpacity(0.85),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Contenido encima
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: (auction['statusColor'] as Color).withOpacity(0.18),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                auction['status'] as String,
                                style: AppTypography.labelSmall.copyWith(
                                  color: auction['statusColor'] as Color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              auction['date'] as String,
                              style: AppTypography.labelSmall.copyWith(color: Colors.white, fontSize: 11),
                            ),
                            SizedBox(height: 8),
                            Text(
                              auction['title'] as String,
                              style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.18),
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  textStyle: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                onPressed: () {
                                  // Navegar a la pantalla de subastas
                                  Navigator.of(context).pushNamed('/auctions');
                                },
                                child: Text('Ver más'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 