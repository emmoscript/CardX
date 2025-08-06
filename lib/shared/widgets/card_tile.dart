import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../models/card.dart' as card_model;

class CardTile extends StatelessWidget {
  final card_model.Card card;
  final VoidCallback? onTap;
  final bool showPrice;
  final bool showSeller;
  final bool showCondition;
  final bool showYugiohStats;

  const CardTile({
    super.key,
    required this.card,
    this.onTap,
    this.showPrice = true,
    this.showSeller = false,
    this.showCondition = true,
    this.showYugiohStats = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 280,
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: AppSpacing.shadowBlur,
              offset: Offset(0, AppSpacing.shadowOffset),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Card Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 120,
                height: 160,
                child: _buildCardImage(),
              ),
            ),
            SizedBox(height: 8),
            // Card Name
            Text(
              card.name,
              style: AppTypography.cardName.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            if (card.setName != null) ...[
              SizedBox(height: 4),
              Text(
                card.setName!,
                style: AppTypography.cardSet.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 4),
            // Game and Rarity - Wrap para evitar overflow
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 4,
              runSpacing: 2,
              children: [
                _buildCompactGameChip(),
                if (card.rarity != null) _buildCompactRarityChip(),
              ],
            ),
            if (showYugiohStats && card.game == card_model.CardGame.yugioh) ...[
              SizedBox(height: 4),
              _buildCompactYugiohStats(),
            ],
            SizedBox(height: 4),
            // Price - Destacado
            if (showPrice && card.price != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.buyGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$24${card.price!.toStringAsFixed(2)}',
                      style: AppTypography.priceSmall.copyWith(
                        color: AppColors.buyGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  if (card.isForSale) ...[
                    SizedBox(width: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.buyGreen,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'SALE',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textInverse,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            Spacer(),
            // Vendedor (icono circular + nombre)
            if (showSeller && card.sellerId != null) ...[
              Divider(height: 16, thickness: 0.5, color: AppColors.border),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.grey200,
                    child: Icon(Icons.person, color: AppColors.grey600, size: 18),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      card.sellerId!,
                      style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w500, fontSize: 11),
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
    );
  }

  Widget _buildCompactYugiohStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Type and Attribute - Single line
        if (card.type != null || card.attribute != null) ...[
          Row(
            children: [
              if (card.type != null) ...[
                Expanded(
                  child: Text(
                    card.type!,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (card.attribute != null) ...[
                SizedBox(width: 4),
                _buildCompactAttributeChip(),
              ],
            ],
          ),
          SizedBox(height: 2),
        ],
        // Level/Rank and ATK/DEF - Compact
        if (card.level != null || card.atk != null || card.def != null) ...[
          Row(
            children: [
              if (card.level != null) ...[
                _buildCompactLevelChip(),
                SizedBox(width: 4),
              ],
              if (card.atk != null) ...[
                _buildCompactStatChip('ATK ${card.atk}', Colors.red),
                SizedBox(width: 4),
              ],
              if (card.def != null) ...[
                _buildCompactStatChip('DEF ${card.def}', Colors.blue),
              ],
            ],
          ),
        ],
        // Archetype - Compact
        if (card.archetype != null) ...[
          SizedBox(height: 2),
          Text(
            card.archetype!,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              fontSize: 9,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildCompactAttributeChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: _getAttributeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: _getAttributeColor().withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        card.attribute!,
        style: AppTypography.labelSmall.copyWith(
          color: _getAttributeColor(),
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
      ),
    );
  }

  Widget _buildCompactLevelChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.amber.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        'LV ${card.level}',
        style: AppTypography.labelSmall.copyWith(
          color: Colors.amber.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
      ),
    );
  }

  Widget _buildCompactStatChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: AppTypography.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
      ),
    );
  }

  Widget _buildCardImage() {
    if (card.imageUrl != null && card.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: card.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildImagePlaceholder(),
        errorWidget: (context, url, error) => _buildImageError(),
      );
    } else {
      return _buildImagePlaceholder();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: AppColors.grey100,
      child: Center(
        child: Icon(
          Icons.image,
          size: AppSpacing.iconSize,
          color: AppColors.grey400,
        ),
      ),
    );
  }

  Widget _buildImageError() {
    return Container(
      color: AppColors.grey100,
      child: Center(
        child: Icon(
          Icons.broken_image,
          size: AppSpacing.iconSize,
          color: AppColors.grey400,
        ),
      ),
    );
  }

  Widget _buildCompactGameChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getGameColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getGameColor().withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        card.game.shortName,
        style: AppTypography.labelSmall.copyWith(
          color: _getGameColor(),
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
    );
  }

  Widget _buildCompactRarityChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getRarityColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getRarityColor().withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        card.rarity!.displayName,
        style: AppTypography.labelSmall.copyWith(
          color: _getRarityColor(),
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
    );
  }

  Color _getGameColor() {
    switch (card.game) {
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

  Color _getAttributeColor() {
    switch (card.attribute?.toLowerCase()) {
      case 'dark':
        return Colors.purple;
      case 'light':
        return Colors.yellow.shade700;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'earth':
        return Colors.brown;
      case 'wind':
        return Colors.green;
      case 'divine':
        return Colors.amber;
      default:
        return AppColors.grey600;
    }
  }

  Color _getRarityColor() {
    switch (card.rarity) {
      case card_model.CardRarity.common:
        return AppColors.grey600;
      case card_model.CardRarity.uncommon:
        return Colors.green;
      case card_model.CardRarity.rare:
        return Colors.blue;
      case card_model.CardRarity.rareHolo:
        return Colors.purple;
      case card_model.CardRarity.ultraRare:
        return Colors.orange;
      case card_model.CardRarity.secretRare:
        return Colors.red;
      case card_model.CardRarity.legendary:
        return Colors.amber;
      // Yu-Gi-Oh! specific rarities
      case card_model.CardRarity.superRare:
        return Colors.green.shade600;
      case card_model.CardRarity.ultimateRare:
        return Colors.purple.shade600;
      case card_model.CardRarity.ghostRare:
        return Colors.grey.shade400;
      case card_model.CardRarity.platinumRare:
        return Colors.grey.shade500;
      case card_model.CardRarity.starlightRare:
        return Colors.pink.shade400;
      case card_model.CardRarity.quarterCenturyRare:
        return Colors.amber.shade600;
      case card_model.CardRarity.prismaticSecretRare:
        return Colors.indigo.shade600;
      case card_model.CardRarity.goldRare:
        return Colors.amber.shade700;
      case card_model.CardRarity.goldSecretRare:
        return Colors.amber.shade800;
      case card_model.CardRarity.parallelRare:
        return Colors.blue.shade400;
      case card_model.CardRarity.parallelSecretRare:
        return Colors.red.shade400;
      case card_model.CardRarity.parallelUltraRare:
        return Colors.orange.shade400;
      case card_model.CardRarity.parallelCommon:
        return AppColors.grey600;
      case card_model.CardRarity.parallelUncommon:
        return Colors.green.shade400;
      case card_model.CardRarity.parallelRareHolo:
        return Colors.purple.shade400;
      case card_model.CardRarity.parallelSecretRareHolo:
        return Colors.red.shade400;
      case card_model.CardRarity.parallelUltraRareHolo:
        return Colors.orange.shade400;
      case card_model.CardRarity.parallelCommonHolo:
        return AppColors.grey600;
      case card_model.CardRarity.parallelUncommonHolo:
        return Colors.green.shade400;
      case card_model.CardRarity.parallelRareHoloSecret:
        return Colors.purple.shade400;
      case card_model.CardRarity.parallelUltraRareHoloSecret:
        return Colors.orange.shade400;
      case card_model.CardRarity.parallelCommonHoloSecret:
        return AppColors.grey600;
      case card_model.CardRarity.parallelUncommonHoloSecret:
        return Colors.green.shade400;
      default:
        return AppColors.grey600;
    }
  }

  Color _getConditionColor() {
    switch (card.condition) {
      case card_model.CardCondition.mint:
        return AppColors.success;
      case card_model.CardCondition.nearMint:
        return AppColors.success;
      case card_model.CardCondition.excellent:
        return AppColors.info;
      case card_model.CardCondition.good:
        return AppColors.warning;
      case card_model.CardCondition.lightPlayed:
        return AppColors.warning;
      case card_model.CardCondition.played:
        return AppColors.error;
      case card_model.CardCondition.poor:
        return AppColors.error;
      default:
        return AppColors.grey600;
    }
  }
} 