import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../models/card.dart' as card_model;
import '../../features/tcg/tcg_card_list_screen.dart';
import '../../features/home/home_screen.dart';

class LatestSinglesSlider extends StatelessWidget {
  final String game;
  final List<card_model.Card> cards;
  final bool isLoading;
  final VoidCallback? onSeeAll;
  final void Function(String tcgName, Color tcgColor, String tcgImage)? onSeeTcgGrid;
  
  const LatestSinglesSlider({
    required this.game,
    required this.cards,
    this.isLoading = false,
    this.onSeeAll,
    this.onSeeTcgGrid,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Últimos singles de $game publicados',
                    style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (onSeeTcgGrid != null) {
                      onSeeTcgGrid!(game, _getTcgColor(game), _getTcgImage(game));
                    }
                  },
                  child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(width: 18),
              itemBuilder: (context, index) {
                return Container(
                  width: 270,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(14),
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
          SizedBox(height: 16),
        ],
      );
    }

    if (cards.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Últimos singles de $game publicados',
                    style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (onSeeTcgGrid != null) {
                      onSeeTcgGrid!(game, _getTcgColor(game), _getTcgImage(game));
                    }
                  },
                  child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            child: Center(
              child: Text(
                'No hay cartas disponibles',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Últimos singles de $game publicados',
                  style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (onSeeTcgGrid != null) {
                    onSeeTcgGrid!(game, _getTcgColor(game), _getTcgImage(game));
                  }
                },
                child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            separatorBuilder: (_, __) => SizedBox(width: 18),
            itemBuilder: (context, index) {
              final card = cards[index];
              return Stack(
                children: [
                  Container(
                    width: 320,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowLight.withOpacity(0.10),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: Image.network(
                            card.imageUrl ?? 'https://via.placeholder.com/250x350/CCCCCC/FFFFFF?text=No+Image',
                            width: 110,
                            height: 150,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 110,
                                height: 150,
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
                              width: 110,
                              height: 150,
                              color: AppColors.grey100,
                              child: Icon(Icons.image, size: 40, color: AppColors.grey400),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(maxWidth: 70),
                                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        _getGameDisplayName(card.game),
                                        style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 10),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    if (card.rarity != null) ...[
                                      Container(
                                        constraints: BoxConstraints(maxWidth: 32),
                                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey200,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          _getRarityDisplayName(card.rarity!),
                                          style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 10),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  card.name,
                                  style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),
                                if (card.setName != null) ...[
                                  Text(
                                    card.setName!,
                                    style: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary, fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                ],
                                if (card.id.isNotEmpty) ...[
                                  Text(
                                    'ID: ${card.id}',
                                    style: AppTypography.labelSmall.copyWith(color: AppColors.grey400, fontSize: 10),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),
                                ],
                                if (card.price != null) ...[
                                  Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(maxWidth: 54),
                                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: AppColors.buyGreen.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '\$${card.price!.toStringAsFixed(2)}',
                                          style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.buyGreen, fontSize: 11),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Badge de idioma en la esquina superior derecha del card
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'EN',
                        style: AppTypography.labelSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
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
      case card_model.CardRarity.legendary:
        return 'L';
      case card_model.CardRarity.superRare:
        return 'SR';
      case card_model.CardRarity.ultimateRare:
        return 'UR';
      case card_model.CardRarity.ghostRare:
        return 'GR';
      case card_model.CardRarity.platinumRare:
        return 'PR';
      case card_model.CardRarity.starlightRare:
        return 'STR';
      case card_model.CardRarity.quarterCenturyRare:
        return 'QCR';
      case card_model.CardRarity.prismaticSecretRare:
        return 'PSR';
      case card_model.CardRarity.goldRare:
        return 'GR';
      case card_model.CardRarity.goldSecretRare:
        return 'GSR';
      case card_model.CardRarity.parallelRare:
        return 'PR';
      case card_model.CardRarity.parallelSecretRare:
        return 'PSR';
      case card_model.CardRarity.parallelUltraRare:
        return 'PUR';
      case card_model.CardRarity.parallelCommon:
        return 'PC';
      case card_model.CardRarity.parallelUncommon:
        return 'PU';
      case card_model.CardRarity.parallelRareHolo:
        return 'PRH';
      case card_model.CardRarity.parallelSecretRareHolo:
        return 'PSRH';
      case card_model.CardRarity.parallelUltraRareHolo:
        return 'PURH';
      case card_model.CardRarity.parallelCommonHolo:
        return 'PCH';
      case card_model.CardRarity.parallelUncommonHolo:
        return 'PUH';
      case card_model.CardRarity.parallelRareHoloSecret:
        return 'PRHS';
      case card_model.CardRarity.parallelUltraRareHoloSecret:
        return 'PURHS';
      case card_model.CardRarity.parallelCommonHoloSecret:
        return 'PCHS';
      case card_model.CardRarity.parallelUncommonHoloSecret:
        return 'PUHS';
      default:
        return 'C';
    }
  }

  Color _getTcgColor(String game) {
    final info = getTcgInfo(game);
    return info.color;
  }

  String _getTcgImage(String game) {
    final info = getTcgInfo(game);
    return info.image;
  }
} 