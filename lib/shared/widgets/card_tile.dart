import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../models/card.dart' as card_model;
import '../../core/services/hive_database_service.dart';
import 'package:hive/hive.dart';

class CardTile extends StatefulWidget {
  final card_model.Card card;
  final VoidCallback? onTap;
  final bool showPrice;
  final bool showCondition;
  final bool showSeller;
  final bool showYugiohStats;
  final bool showFavoriteButton;

  const CardTile({
    Key? key,
    required this.card,
    this.onTap,
    this.showPrice = true,
    this.showCondition = true,
    this.showSeller = true,
    this.showYugiohStats = false,
    this.showFavoriteButton = true,
  }) : super(key: key);

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  bool _isFavorite = false;
  final HiveDatabaseService _database = HiveDatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    // Get current user ID from Hive
    var box = Hive.box('userBox');
    String userId = box.get('userId', defaultValue: '');
    
    if (userId.isNotEmpty) {
      final isFavorite = await _database.isInCollection(userId, widget.card.id);
      if (mounted) {
        setState(() {
          _isFavorite = isFavorite;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    // Get current user ID from Hive
    var box = Hive.box('userBox');
    String userId = box.get('userId', defaultValue: '');
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    
    if (!isLoggedIn || userId.isEmpty) {
      // Show login prompt if user is not logged in
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Debes iniciar sesión para agregar favoritos'),
            backgroundColor: AppColors.warning,
            action: SnackBarAction(
              label: 'Iniciar Sesión',
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('/auth');
              },
            ),
          ),
        );
      }
      return;
    }
    
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    try {
      // Add to favorites in database
      if (_isFavorite) {
        await _database.addToCollection(userId, widget.card.id);
      } else {
        await _database.removeFromCollection(userId, widget.card.id);
      }
      
      // Show feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavorite ? 'Agregado a favoritos' : 'Removido de favoritos'),
            duration: Duration(seconds: 1),
            backgroundColor: _isFavorite ? AppColors.buyGreen : AppColors.sellRed,
          ),
        );
      }
    } catch (e) {
      // Revert state if there was an error
      setState(() {
        _isFavorite = !_isFavorite;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar favoritos'),
            backgroundColor: AppColors.sellRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
        ),
        child: Container(
          width: 180,
          height: 300,
          padding: EdgeInsets.all(AppSpacing.md),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Card Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 120,
                    height: 160,
                    child: _buildCardImage(theme),
                  ),
                ),
                SizedBox(height: 8),
                // Card Name
                Text(
                  widget.card.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                if (widget.card.setName != null) ...[
                  SizedBox(height: 4),
                  Text(
                    widget.card.setName!,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
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
                    _buildCompactGameChip(theme),
                    if (widget.card.rarity != null) _buildCompactRarityChip(theme),
                  ],
                ),
                if (widget.showYugiohStats && widget.card.game == card_model.CardGame.yugioh) ...[
                  SizedBox(height: 4),
                  _buildCompactYugiohStats(theme),
                ],
                SizedBox(height: 4),
                // Price - Destacado
                if (widget.showPrice && widget.card.price != null)
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.buyGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${widget.card.price!.toStringAsFixed(2)}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.buyGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (widget.card.isForSale)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.buyGreen,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'EN VENTA',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                // Condition
                if (widget.showCondition && widget.card.condition != null) ...[
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getConditionColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _getConditionColor().withOpacity(0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      widget.card.condition!.displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _getConditionColor(),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
                // Seller info
                if (widget.showSeller && widget.card.sellerId != null) ...[
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.card.sellerId!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
                // Favorite button
                if (widget.showFavoriteButton) ...[
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _toggleFavorite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFavorite ? AppColors.sellRed.withOpacity(0.1) : AppColors.grey100,
                        foregroundColor: _isFavorite ? AppColors.sellRed : AppColors.textSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        elevation: 0,
                        minimumSize: Size(0, 32),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _isFavorite ? 'Favorito' : 'Agregar',
                            style: AppTypography.labelSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage(ThemeData theme) {
    if (widget.card.imageUrl != null && widget.card.imageUrl!.isNotEmpty) {
      return Image.network(
        widget.card.imageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: theme.colorScheme.surface,
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
            color: theme.colorScheme.surface,
            child: Icon(
              Icons.image,
              size: 40,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          );
        },
      );
    } else {
      return Container(
        color: theme.colorScheme.surface,
        child: Icon(
          Icons.image,
          size: 40,
          color: theme.colorScheme.onSurface.withOpacity(0.5),
        ),
      );
    }
  }

  Widget _buildCompactGameChip(ThemeData theme) {
    final color = _getGameColor();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        widget.card.game.shortName,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
    );
  }

  Widget _buildCompactRarityChip(ThemeData theme) {
    final color = _getRarityColor();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
              child: Text(
          widget.card.rarity!.displayName,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 9,
          ),
        ),
    );
  }

  Widget _buildCompactYugiohStats(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Type and Attribute - Single line
        if (widget.card.type != null || widget.card.attribute != null) ...[
          Row(
            children: [
              if (widget.card.type != null) ...[
                Expanded(
                  child: Text(
                    widget.card.type!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (widget.card.attribute != null) ...[
                SizedBox(width: 4),
                _buildCompactAttributeChip(theme),
              ],
            ],
          ),
          SizedBox(height: 2),
        ],
        // Level/Rank and ATK/DEF - Compact
        if (widget.card.level != null || widget.card.atk != null || widget.card.def != null) ...[
          Row(
            children: [
              if (widget.card.level != null) ...[
                _buildCompactLevelChip(theme),
                SizedBox(width: 4),
              ],
              if (widget.card.atk != null) ...[
                _buildCompactStatChip('ATK ${widget.card.atk}', Colors.red, theme),
                SizedBox(width: 4),
              ],
              if (widget.card.def != null) ...[
                _buildCompactStatChip('DEF ${widget.card.def}', Colors.blue, theme),
              ],
            ],
          ),
        ],
        // Archetype - Compact
        if (widget.card.archetype != null) ...[
          SizedBox(height: 2),
          Text(
            widget.card.archetype!,
            style: theme.textTheme.labelSmall?.copyWith(
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

  Widget _buildCompactAttributeChip(ThemeData theme) {
    final color = _getAttributeColor();
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
        widget.card.attribute!,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
      ),
    );
  }

  Widget _buildCompactLevelChip(ThemeData theme) {
    final color = Colors.amber;
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
        'LV ${widget.card.level}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
      ),
    );
  }

  Widget _buildCompactStatChip(String text, Color color, ThemeData theme) {
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
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
      ),
    );
  }

  Color _getGameColor() {
    switch (widget.card.game) {
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
    switch (widget.card.attribute?.toLowerCase()) {
      case 'light':
        return Colors.yellow;
      case 'dark':
        return Colors.purple;
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
    switch (widget.card.rarity) {
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
    switch (widget.card.condition) {
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