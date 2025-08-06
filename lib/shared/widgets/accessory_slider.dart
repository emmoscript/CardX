import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';

class AccessorySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> accessories = [
      {
        'image': 'assets/images/pokemon_logo.png',
        'title': 'Pokémon Elite Trainer Box',
        'category': 'Mazos',
        'price': '\$45.99',
        'originalPrice': '\$59.99',
        'discount': '23%',
      },
      {
        'image': 'assets/images/yugioh_logo.png',
        'title': 'Yu-Gi-Oh! Structure Deck',
        'category': 'Mazos',
        'price': '\$12.99',
        'originalPrice': '\$15.99',
        'discount': '19%',
      },
      {
        'image': 'assets/images/magic_logo.png',
        'title': 'Magic Commander Deck',
        'category': 'Mazos',
        'price': '\$38.99',
        'originalPrice': '\$44.99',
        'discount': '13%',
      },
      {
        'image': 'assets/images/pokemon_logo.png',
        'title': 'Pikachu Figurine',
        'category': 'Figurines',
        'price': '\$24.99',
        'originalPrice': '\$29.99',
        'discount': '17%',
      },
      {
        'image': 'assets/images/yugioh_logo.png',
        'title': 'Blue-Eyes Dragon Statue',
        'category': 'Figurines',
        'price': '\$89.99',
        'originalPrice': '\$119.99',
        'discount': '25%',
      },
      {
        'image': 'assets/images/magic_logo.png',
        'title': 'MTG Playmat Premium',
        'category': 'Merch',
        'price': '\$19.99',
        'originalPrice': '\$24.99',
        'discount': '20%',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Accesorios', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('Ver más', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 214,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: accessories.length,
            separatorBuilder: (_, __) => SizedBox(width: 16),
            itemBuilder: (context, index) {
              final accessory = accessories[index];
              return Container(
                width: 160,
                height: 200,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen del accesorio
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Container(
                        height: 100,
                        width: 160,
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                accessory['image'] as String,
                                height: 60,
                                width: 60,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(Icons.image, size: 40, color: AppColors.grey400),
                              ),
                            ),
                            // Badge de descuento
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.buyGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  accessory['discount'] as String,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Contenido
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              accessory['category'] as String,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            accessory['title'] as String,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                accessory['price'] as String,
                                style: AppTypography.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.buyGreen,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                accessory['originalPrice'] as String,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.grey400,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
      ],
    );
  }
} 