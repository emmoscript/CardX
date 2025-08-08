import 'package:flutter/material.dart';
import 'dart:io';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/models/card.dart' as card_model;

class ItemDetailScreen extends StatelessWidget {
  final card_model.Card item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Item'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Implementar edición del item
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Función de edición próximamente')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.grey100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: item.imageUrl!.startsWith('http')
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.image, size: 64, color: AppColors.grey400),
                          );
                        },
                      )
                    : Image.file(
                        File(item.imageUrl!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.image, size: 64, color: AppColors.grey400),
                          );
                        },
                      ),
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.grey100,
                ),
                child: Center(
                  child: Icon(Icons.image, size: 64, color: AppColors.grey400),
                ),
              ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Item details
            _buildDetailSection('Información del Item', [
              _buildDetailRow('Nombre', item.name),
              _buildDetailRow('Juego', item.game.shortName),
              if (item.setName != null) _buildDetailRow('Categoría', item.setName!),
              if (item.condition != null) _buildDetailRow('Condición', item.condition!.displayName),
              if (item.rarity != null) _buildDetailRow('Rareza', item.rarity!.displayName),
            ]),
            
            const SizedBox(height: AppSpacing.md),
            
            // Price and availability
            _buildDetailSection('Precio y Disponibilidad', [
              if (item.price != null) _buildDetailRow('Precio', '\$${item.price!.toStringAsFixed(2)}'),
              _buildDetailRow('En Venta', item.isForSale ? 'Sí' : 'No'),
              _buildDetailRow('Para Intercambio', item.isForTrade ? 'Sí' : 'No'),
            ]),
            
            const SizedBox(height: AppSpacing.md),
            
            // Item ID
            _buildDetailSection('Información Técnica', [
              _buildDetailRow('ID del Item', item.id),
              _buildDetailRow('Fecha de Creación', _formatDate(item.createdAt)),
              _buildDetailRow('Última Actualización', _formatDate(item.updatedAt)),
            ]),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implementar función de editar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Función de edición próximamente')),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Editar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    icon: Icon(Icons.delete, color: AppColors.error),
                    label: Text('Eliminar', style: TextStyle(color: AppColors.error)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Item'),
        content: Text('¿Estás seguro de que quieres eliminar "${item.name}"? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implementar eliminación del item
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item eliminado'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Eliminar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
