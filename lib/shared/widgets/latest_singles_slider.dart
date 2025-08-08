import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../models/card.dart' as card_model;
import '../../features/tcg/tcg_card_list_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/tcg/tcg_card_detail_screen.dart';

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
          height: 150, // Standardized height for all singles
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: cards.take(3).length, // Show only 3 cards like Star Wars
            separatorBuilder: (_, __) => SizedBox(width: 18), // Consistent spacing
            itemBuilder: (context, index) {
              final card = cards[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to card detail page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TcgCardDetailScreen(card: card),
                    ),
                  );
                },
                child: Container(
                  width: 320,
                  height: 200, // Reduced height to be more compact
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
                      // Image section
                      Container(
                        width: 120,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                          ),
                          child: Image.network(
                            card.imageUrl ?? 'https://via.placeholder.com/250x350/CCCCCC/FFFFFF?text=No+Image',
                            width: 120,
                            height: 200,
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft, // Align to left to show full card
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 120,
                                height: 200,
                                color: AppColors.grey100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 200,
                                color: AppColors.grey100,
                                child: Icon(Icons.image, size: 40, color: AppColors.grey400),
                              );
                            },
                          ),
                        ),
                      ),
                      // Content section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top row: Game and Rarity badges side by side
                              Row(
                                children: [
                                  // Game badge
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getGameColor(card.game).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
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
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  // Rarity badge
                                  if (card.rarity != null)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getRarityColor(card.rarity!).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: _getRarityColor(card.rarity!).withOpacity(0.3),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        card.rarity!.displayName,
                                        style: AppTypography.labelSmall.copyWith(
                                          color: _getRarityColor(card.rarity!),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ),
                                  Spacer(),
                                  // Language badge in top-right
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      _getLanguageBadge(card),
                                      style: AppTypography.labelSmall.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // Card name
                              Expanded(
                                child: Text(
                                  card.name,
                                  style: AppTypography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 6),
                              // Set name (if available)
                              if (card.setName != null) ...[
                                Text(
                                  card.setName!,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                              ],
                              // Bottom row: ID and Price
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'ID: ${card.id}',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                  if (card.price != null)
                                    Text(
                                      '\$${card.price!.toStringAsFixed(2)}',
                                      style: AppTypography.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.buyGreen,
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
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

  String _getLanguageBadge(card_model.Card card) {
    // For now, return EN as default since CardLanguage is not defined
    return 'EN';
  }

  Color _getGameColor(card_model.CardGame game) {
    switch (game) {
      case card_model.CardGame.pokemon:
        return AppColors.pokemon;
      case card_model.CardGame.yugioh:
        return AppColors.yugioh;
      case card_model.CardGame.mtg:
        return AppColors.primary;
      default:
        return AppColors.primary;
    }
  }

  Color _getRarityColor(card_model.CardRarity rarity) {
    switch (rarity) {
      case card_model.CardRarity.common:
        return AppColors.textSecondary;
      case card_model.CardRarity.uncommon:
        return AppColors.textSecondary;
      case card_model.CardRarity.rare:
        return AppColors.primary;
      case card_model.CardRarity.rareHolo:
        return AppColors.primary;
      case card_model.CardRarity.ultraRare:
        return AppColors.warning;
      case card_model.CardRarity.secretRare:
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }
} 