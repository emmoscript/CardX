import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../models/card.dart' as card_model;

class PriceUpdateSlider extends StatelessWidget {
  final List<card_model.Card> cards;
  final bool isLoading;
  
  const PriceUpdateSlider({
    required this.cards,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Actualización de precios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(width: 20),
              itemBuilder: (context, index) {
                return Container(
                  width: 180,
                  height: 250,
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 44),
        ],
      );
    }

    if (cards.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Actualización de precios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: Center(
              child: Text(
                'No hay actualizaciones de precios disponibles',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ),
          SizedBox(height: 44),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Actualización de precios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 360,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            separatorBuilder: (_, __) => SizedBox(width: 20),
            itemBuilder: (context, index) {
              final card = cards[index];
              // Simular tendencia de precio (en una app real esto vendría de la API)
              final trend = _generateRandomTrend();
              final seller = _generateRandomSeller();
              
              return Container(
                width: 180,
                height: 340,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight.withOpacity(0.06),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen de la carta
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                      child: AspectRatio(
                        aspectRatio: 0.7,
                        child: Image.network(
                          card.imageUrl ?? 'https://via.placeholder.com/250x350/CCCCCC/FFFFFF?text=No+Image',
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: AppColors.grey100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.grey100,
                            child: Icon(Icons.image, size: 60, color: AppColors.grey400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Franja inferior con precio y porcentaje
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '\$${_formatPrice(card.price ?? 0)} USD',
                              style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold, fontSize: 17, color: AppColors.primary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 12),
                          _TrendBadge(trend: trend),
                        ],
                      ),
                    ),
                    // Vendedor debajo de la carta
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: AppColors.grey200,
                            child: Icon(Icons.person, color: AppColors.grey600, size: 16),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              seller,
                              style: AppTypography.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 44),
      ],
    );
  }

  String _formatPrice(double price) {
    // Future-proof: 1K, 25K, 100K, 1M, etc.
    if (price >= 1000000) {
      double millions = price / 1000000;
      return '${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
    } else if (price >= 1000) {
      double thousands = price / 1000;
      return '${thousands.toStringAsFixed(thousands.truncateToDouble() == thousands ? 0 : 1)}K';
    } else {
      return '${price.toStringAsFixed(0)}';
    }
  }

  int _generateRandomTrend() {
    // Simular tendencia aleatoria entre -20 y +30
    return -20 + (DateTime.now().millisecondsSinceEpoch % 51);
  }

  String _generateRandomSeller() {
    final sellers = ['matias rojas', 'Erick Krüger', 'Carlos López', 'Ana García', 'Miguel Torres'];
    return sellers[DateTime.now().millisecondsSinceEpoch % sellers.length];
  }
}

class _TrendBadge extends StatelessWidget {
  final int trend;
  const _TrendBadge({required this.trend});
  @override
  Widget build(BuildContext context) {
    final isUp = trend >= 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isUp ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isUp ? Icons.arrow_upward : Icons.arrow_downward, size: 15, color: isUp ? Colors.green : Colors.red),
          SizedBox(width: 2),
          Text('${trend.abs()}%', style: TextStyle(fontSize: 14, color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
} 