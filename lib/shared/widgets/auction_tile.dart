import 'package:flutter/material.dart';
import 'package:cardx/core/constants/app_colors.dart';
import 'package:cardx/core/constants/app_spacing.dart';
import 'package:cardx/core/constants/app_typography.dart';
import 'package:cardx/shared/models/auction.dart';
import 'package:cardx/shared/widgets/tcg_utils.dart';

class AuctionTile extends StatelessWidget {
  final Auction auction;
  final VoidCallback? onTap;
  final VoidCallback? onWatch;
  final bool? isWatched;

  const AuctionTile({
    super.key,
    required this.auction,
    this.onTap,
    this.onWatch,
    this.isWatched,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con imagen y info básica
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen de la carta
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.xs),
                    child: Container(
                      width: 80,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                      ),
                      child: auction.card.imageUrl != null
                          ? Image.network(
                              auction.card.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage();
                              },
                            )
                          : _buildPlaceholderImage(),
                    ),
                  ),
                  
                  const SizedBox(width: AppSpacing.md),
                  
                  // Información de la subasta
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título y TCG
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                auction.title,
                                style: AppTypography.h6.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: TcgUtils.getTcgColor(auction.tcg),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                auction.tcg.toUpperCase(),
                                style: AppTypography.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: AppSpacing.xs),
                        
                        // Nombre de la carta
                        Text(
                          auction.card.name,
                          style: AppTypography.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: AppSpacing.xs),
                        
                        // Vendedor
                        if (auction.sellerName != null)
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                auction.sellerName!,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        
                        const SizedBox(height: AppSpacing.sm),
                        
                        // Precio actual
                        Row(
                          children: [
                            Text(
                              'Precio actual:',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '\$${auction.currentPrice.toStringAsFixed(2)}',
                              style: AppTypography.h6.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        
                        // Puja mínima
                        Text(
                          'Puja mínima: \$${auction.nextBidAmount.toStringAsFixed(2)}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Botón de favorito
                  if (onWatch != null)
                    IconButton(
                      onPressed: onWatch,
                      icon: Icon(
                        isWatched == true ? Icons.favorite : Icons.favorite_border,
                        color: isWatched == true ? AppColors.error : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Footer con tiempo restante y estadísticas
              Row(
                children: [
                  // Tiempo restante
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: _getTimeRemainingColor(),
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            auction.timeRemainingText,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: AppSpacing.md),
                  
                  // Estadísticas
                  Row(
                    children: [
                      _buildStat(Icons.remove_red_eye, '${auction.views ?? 0}'),
                      const SizedBox(width: AppSpacing.sm),
                      _buildStat(Icons.gavel, '${auction.totalBids ?? 0}'),
                    ],
                  ),
                ],
              ),
              
              // Indicadores especiales
              if (auction.hasReserve || auction.hasBuyNow)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Row(
                    children: [
                      if (auction.hasReserve)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.warning,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Reserva',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (auction.hasReserve && auction.hasBuyNow)
                        const SizedBox(width: AppSpacing.xs),
                      if (auction.hasBuyNow)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Compra Ya',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.xs),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 32,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Sin imagen',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Color _getTimeRemainingColor() {
    final remaining = auction.timeRemaining;
    
    if (remaining.inHours < 1) {
      return AppColors.error; // Rojo para menos de 1 hora
    } else if (remaining.inHours < 6) {
      return AppColors.warning; // Naranja para menos de 6 horas
    } else if (remaining.inDays < 1) {
      return AppColors.info; // Azul para menos de 1 día
    } else {
      return AppColors.success; // Verde para más de 1 día
    }
  }
} 