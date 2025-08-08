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
    final theme = Theme.of(context);
    
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Actualización de precios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
                     SizedBox(
             height: 250,
             child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                return Container(
                  width: 180,
                  height: 250,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
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
          const SizedBox(height: 44),
        ],
      );
    }

    if (cards.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Actualización de precios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
                     SizedBox(
             height: 250,
             child: Center(
              child: Text(
                'No hay actualizaciones de precios disponibles',
                style: AppTypography.bodyMedium.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6)),
              ),
            ),
          ),
          const SizedBox(height: 44),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Actualización de precios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 390, // Increased height to prevent overflow
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final card = cards[index];
              final trend = _generateRandomTrend();
              final seller = _generateRandomSeller();
              
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Container(
                  width: 180,
                  height: 370, // Increased height to prevent overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen de la carta
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                        child: AspectRatio(
                          aspectRatio: 0.7,
                          child: card.imageUrl != null && card.imageUrl!.isNotEmpty
                            ? Image.network(
                                card.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: theme.colorScheme.surface,
                                  child: Icon(Icons.image, size: 60, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                                ),
                              )
                            : Container(
                                color: theme.colorScheme.surface,
                                child: Icon(Icons.image, size: 60, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                              ),
                        ),
                      ),
                      // Información de la carta
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nombre de la carta
                              Text(
                                card.name,
                                style: AppTypography.labelMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6), // Reduced spacing
                              // Información del vendedor con avatar
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10, // Reduced size
                                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      size: 12, // Reduced size
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 4), // Reduced spacing
                                  Expanded(
                                    child: Text(
                                      seller,
                                      style: AppTypography.labelSmall.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                                        fontSize: 10, // Smaller font
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6), // Reduced spacing
                              // Precio y tendencia
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '\$${_formatPrice(card.price ?? 0)}',
                                      style: AppTypography.labelMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.buyGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4), // Reduced spacing
                                  _TrendBadge(trend: trend),
                                ],
                              ),
                              const Spacer(),
                              // Badge de juego
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), // Reduced padding
                                decoration: BoxDecoration(
                                  color: _getGameColor(card.game).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(3), // Smaller radius
                                  border: Border.all(
                                    color: _getGameColor(card.game).withOpacity(0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  card.game.shortName,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: _getGameColor(card.game),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8, // Smaller font
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 44),
      ],
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

  int _generateRandomTrend() {
    final random = DateTime.now().millisecond;
    return (random % 21) - 10; // Returns values between -10 and 10
  }

  String _generateRandomSeller() {
    final sellers = ['CardMaster', 'TCGPro', 'EliteCards', 'RareFind', 'CardHaven'];
    final random = DateTime.now().millisecond;
    return sellers[random % sellers.length];
  }

  Color _getGameColor(card_model.CardGame game) {
    switch (game) {
      case card_model.CardGame.pokemon:
        return Colors.red;
      case card_model.CardGame.mtg:
        return Colors.blue;
      case card_model.CardGame.yugioh:
        return Colors.orange;
      case card_model.CardGame.starWarsUnlimited:
        return Colors.amber;
      case card_model.CardGame.onePiece:
        return Colors.deepPurple;
      case card_model.CardGame.dragonBall:
        return Colors.deepOrange;
      case card_model.CardGame.digimon:
        return Colors.teal;
      case card_model.CardGame.gundam:
        return Colors.grey;
      case card_model.CardGame.starWars:
        return Colors.amberAccent;
      default:
        return AppColors.grey600;
    }
  }

  String _getGameDisplayName(card_model.CardGame game) {
    switch (game) {
      case card_model.CardGame.pokemon:
        return 'Pokémon';
      case card_model.CardGame.yugioh:
        return 'Yu-Gi-Oh!';
      case card_model.CardGame.mtg:
        return 'Magic';
      default:
        return 'TCG';
    }
  }

  String _getRarityDisplayName(card_model.CardRarity rarity) {
    switch (rarity) {
      case card_model.CardRarity.common:
        return 'C';
      case card_model.CardRarity.uncommon:
        return 'U';
      case card_model.CardRarity.rare:
        return 'R';
      case card_model.CardRarity.rareHolo:
        return 'RH';
      case card_model.CardRarity.ultraRare:
        return 'UR';
      case card_model.CardRarity.secretRare:
        return 'SR';
      default:
        return 'C';
    }
  }

  String _getRandomTrend() {
    final trends = ['up', 'down', 'stable'];
    return trends[DateTime.now().millisecond % trends.length];
  }

  double _getRandomTrendValue() {
    return (DateTime.now().millisecond % 50) / 10.0;
  }
}

class _TrendBadge extends StatelessWidget {
  final int trend;
  const _TrendBadge({required this.trend});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUp = trend >= 0;
    final color = isUp ? AppColors.buyGreen : AppColors.sellRed;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.4), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward : Icons.arrow_downward,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 2),
          Text(
            '${trend.abs()}%',
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 